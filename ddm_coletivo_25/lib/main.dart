import 'package:ddm_coletivo_25/not_used.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';
import 'package:cloud_functions/cloud_functions.dart';
// https://isaacadariku.medium.com/google-sign-in-flutter-migration-guide-pre-7-0-versions-to-v7-version-cdc9efd7f182

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize GoogleSignIn for non-web platforms (v7.0+ requirement)
  if (!kIsWeb) {
    try {
      await GoogleSignIn.instance.initialize();
    } catch (e) {
      debugPrint('Failed to initialize Google Sign-In: $e');
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Login Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // wait for auth initialization
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          return const HomePage();
        }
        return const LoginScreen();
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isSigningIn = false;
  String? _errorMessage;
  bool _isSignUpMode = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signInWithEmailPassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSigningIn = true;
      _errorMessage = null;
    });

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      UserCredential userCredential;

      if (_isSignUpMode) {
        userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      }

      final user = userCredential.user;
      if (user != null) {
        await _upsertUserToFirestore(user);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        switch (e.code) {
          case 'user-not-found':
            _errorMessage = 'No user found with this email.';
            break;
          case 'wrong-password':
            _errorMessage = 'Incorrect password.';
            break;
          case 'email-already-in-use':
            _errorMessage = 'An account already exists with this email.';
            break;
          case 'weak-password':
            _errorMessage = 'Password is too weak. Use at least 6 characters.';
            break;
          case 'invalid-email':
            _errorMessage = 'Invalid email address.';
            break;
          default:
            _errorMessage = e.message ?? 'Authentication failed.';
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred.';
      });
      debugPrint('Email/Password auth error: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isSigningIn = false;
        });
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isSigningIn = true;
      _errorMessage = null;
    });

    try {
      if (kIsWeb) {
        // Web: Use Firebase popup flow
        final provider = GoogleAuthProvider();
        final userCredential =
            await FirebaseAuth.instance.signInWithPopup(provider);

        final user = userCredential.user;
        if (user != null) {
          await _upsertUserToFirestore(user);
        }
      } else {
        // Mobile/Desktop: Use v7.0+ authenticate() method
        final GoogleSignInAccount account =
            await GoogleSignIn.instance.authenticate(
          scopeHint: ['email'],
        );

        // In v7.0+, authentication is now synchronous (no await)
        final auth = account.authentication;

        if (auth.idToken == null) {
          throw Exception('No idToken returned by Google sign-in.');
        }
        String? accessToken;
 try {
          accessToken =
              (auth as dynamic).accessToken ?? (auth as dynamic).access_token;
        } catch (_) {
          // ignore
        }        

        final credential = GoogleAuthProvider.credential(
          idToken: auth.idToken,
          accessToken: accessToken,
        );

        final userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        final user = userCredential.user;
        if (user != null) {
          await _upsertUserToFirestore(user);
        }
      }
    } on GoogleSignInException catch (e) {
      setState(() {
        _errorMessage =
            _googleSignInExceptionToMessage(e) ?? 'Google sign-in failed.';
      });
      debugPrint(
          'Google Sign In error: code: ${e.code.name}, description: ${e.description}');
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'popup-closed-by-user' || e.code == 'cancelled') {
          _errorMessage = null;
        } else {
          _errorMessage = e.message ?? 'Google sign-in failed.';
        }
      });
    } catch (e, st) {
      setState(() {
        _errorMessage = 'Google sign-in error. Please try again.';
      });
      debugPrint('Google sign-in error: $e\n$st');
    } finally {
      if (mounted) {
        setState(() {
          _isSigningIn = false;
        });
      }
    }
  }

  String? _googleSignInExceptionToMessage(GoogleSignInException exception) {
    switch (exception.code.name) {
      case 'canceled':
        return null; // User cancelled, don't show error
      case 'interrupted':
        return 'Sign-in was interrupted. Please try again.';
      case 'clientConfigurationError':
        return 'Configuration issue with Google Sign-In. Please contact support.';
      case 'providerConfigurationError':
        return 'Google Sign-In is currently unavailable. Please try again later.';
      case 'uiUnavailable':
        return 'Google Sign-In is currently unavailable. Please try again later.';
      case 'userMismatch':
        return 'Account mismatch. Please sign out and try again.';
      default:
        return 'An unexpected error occurred during Google Sign-In.';
    }
  }

  Future<void> _upsertUserToFirestore(User user) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'name': user.displayName,
        'email': user.email,
        'photoUrl': user.photoURL,
        'lastLogin': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint('Failed to upsert user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.all(24),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const FlutterLogo(size: 72),
                    const SizedBox(height: 16),
                    Text(
                      _isSignUpMode ? 'Create Account' : 'Sign In',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Email field
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      enabled: !_isSigningIn,
                    ),
                    const SizedBox(height: 16),

                    // Password field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (_isSignUpMode && value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      enabled: !_isSigningIn,
                    ),
                    const SizedBox(height: 20),

                    // Email/Password Sign In/Up Button
                    ElevatedButton(
                      onPressed: _isSigningIn ? null : _signInWithEmailPassword,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: _isSigningIn
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(_isSignUpMode ? 'Sign Up' : 'Sign In'),
                    ),
                    const SizedBox(height: 12),

                    // Toggle Sign Up/Sign In
                    TextButton(
                      onPressed: _isSigningIn
                          ? null
                          : () {
                              setState(() {
                                _isSignUpMode = !_isSignUpMode;
                                _errorMessage = null;
                              });
                            },
                      child: Text(
                        _isSignUpMode
                            ? 'Already have an account? Sign In'
                            : 'Don\'t have an account? Sign Up',
                      ),
                    ),

                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),

                    // Google Sign In Button
                    OutlinedButton.icon(
                      onPressed: _isSigningIn ? null : _signInWithGoogle,
                      icon: const Icon(Icons.login),
                      label: const Text('Continue with Google'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),

                    if (_errorMessage != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red.shade200),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.error_outline,
                                color: Colors.red.shade700),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _errorMessage!,
                                style: TextStyle(color: Colors.red.shade700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    if (!kIsWeb) {
      try {
        await GoogleSignIn.instance.signOut();
      } catch (e) {
        debugPrint('GoogleSignIn signOut error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _signOut();
            },
          )
        ],
      ),
      body: Center(
        child: user == null
            ? const Text('No user signed in.')
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (user.photoURL != null && user.photoURL!.isNotEmpty)
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(user.photoURL!),
                    )
                  else
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.blue.shade200,
                      child: Text(
                        (user.displayName ?? user.email ?? 'U')[0]
                            .toUpperCase(),
                        style: const TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ),
                  const SizedBox(height: 12),
                  Text(
                    'Hello, ${user.displayName ?? user.email?.split('@').first ?? 'User'}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 6),
                  Text(user.email ?? ''),
                  const SizedBox(height: 20),
                ],
              ),
      ),
    );
  }
}

/// create a folder in firebase for each student email in the list. Use the email
/// till the @ as the folder name.
void createFolderForEachStudent(List<String> emails) {
  final firestore = FirebaseFirestore.instance;

  for (final email in emails) {
    final folderName = email.split('@').first;
    firestore.collection('students').doc(folderName).set({
      'email': email,
    });
    print('Created folder for $folderName');
  }
}

void createNewLoginForUser(String newEmail, String newPassword) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: newEmail,
      password: newPassword,
    );
    print('New user created: ${userCredential.user?.uid}');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    } else {
      print(e);
    }
  } catch (e) {
    print(e);
  }
}

Future<void> makeJoseAdmin() async {
  makeUserAdminFromApp('fiP5NpKzjNUSBMbCbOXhVN4TqZH3');
}
