import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize GoogleSignIn only for non-web to avoid issues on web platforms.
  if (!kIsWeb) {
    await GoogleSignIn.instance.initialize();
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

/// Shows a loading indicator while Firebase Auth state is determined,
/// then shows LoginScreen or HomePage depending on auth.
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
  bool _isSigningIn = false;
  String? _errorMessage;

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
        // Mobile/Desktop: use the new GoogleSignIn API
        // authenticate() performs interactive sign-in
        final GoogleSignInAccount account =
            await GoogleSignIn.instance.authenticate();

        // Defensive: platform implementations may return differing token fields.
        final auth = await account.authentication;

        // Try common naming variants defensively
        String? idToken;
        String? accessToken;
        try {
          // Prefer Dart-style fields if present
          idToken = (auth as dynamic).idToken ?? (auth as dynamic).id_token;
        } catch (_) {
          // ignore
        }
        try {
          accessToken =
              (auth as dynamic).accessToken ?? (auth as dynamic).access_token;
        } catch (_) {
          // ignore
        }

        if (idToken == null && accessToken == null) {
          throw Exception(
              'No idToken or accessToken returned by Google sign-in. Check OAuth configuration.');
        }

        final credential = GoogleAuthProvider.credential(
          idToken: idToken,
          accessToken: accessToken,
        );

        final userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        final user = userCredential.user;
        if (user != null) {
          await _upsertUserToFirestore(user);
        }
      }
      // On success, StreamBuilder in AuthGate will navigate to HomePage automatically.
    } catch (e, st) {
      // Show a friendly error message for UI
      setState(() {
        _errorMessage = e.toString();
      });
      // Helpful debug print
      debugPrint('Google sign-in error: $e\n$st');
    } finally {
      if (mounted) {
        setState(() {
          _isSigningIn = false;
        });
      }
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
        child: Card(
          margin: const EdgeInsets.all(24),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const FlutterLogo(size: 72),
                const SizedBox(height: 16),
                const Text(
                  'Sign in with Google',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _isSigningIn ? null : _signInWithGoogle,
                  icon: _isSigningIn
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.login),
                  label: const Text('Continue with Google'),
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12)),
                ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ],
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
    // Firebase sign out
    await FirebaseAuth.instance.signOut();
    // For non-web platforms, also sign out from GoogleSignIn instance
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
                    ),
                  const SizedBox(height: 12),
                  Text(
                    'Hello, ${user.displayName ?? 'User'}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 6),
                  Text(user.email ?? ''),
                ],
              ),
      ),
    );
  }
}
