import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final supabase = Supabase.instance.client;

  Future<void> _signInWithGoogle() async {
  try {
    final response = await supabase.auth.signInWithOAuth(
      OAuthProvider.google,                     // provider
      redirectTo: 'io.ddmoauth://callback',     // optional deep link redirect
      authScreenLaunchMode: LaunchMode.externalApplication,
    );
    // Optionally inspect `response` for redirect URL if needed
  } catch (error) {
    debugPrint('OAuth sign-in error: $error');
  }
}

// And listen for completion:
@override
void initState() {
  super.initState();
  supabase.auth.onAuthStateChange.listen((data) {
    if (data.event == AuthChangeEvent.signedIn) {
      final session = supabase.auth.currentSession;
      debugPrint('Signed in as ${session?.user.email}');
      setState(() {});
    }
  });
}

  @override
  Widget build(BuildContext context) {
    final session = supabase.auth.currentSession;
    return Scaffold(
      appBar: AppBar(title: const Text('DDM-OAuth Auth')),
      body: Center(
        child: session == null
            ? ElevatedButton(
                onPressed: _signInWithGoogle,
                child: const Text('Sign in with Google'),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Hello, ${session.user.email}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => supabase.auth.signOut(),
                    child: const Text('Sign out'),
                  ),
                ],
              ),
      ),
    );
  }
}
