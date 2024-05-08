import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:template_riverpod_go_router/providers/providers.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  static LoginScreen builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const LoginScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    final auth = ref.watch(authProvider.notifier);
    final GoogleSignIn googleSignIn = GoogleSignIn();

    Future<void> _signInWithEmailAndPassword() async {
      try {
        await auth.signInWithEmailAndPassword(
          _emailController.text.trim(),
           _passwordController.text.trim(),
        );
        // Authentication successful, navigate back to chat screen
        Navigator.of(context).pop();
      } catch (e) {
        // Handle authentication errors
        print('Failed to sign in with email and password: $e');
        // Display error message to the user (e.g., using a SnackBar)
      }
    }

    Future<void> _registerUserWithEmailAndPassword() async {
      try {
        await auth.registerUserWithEmailAndPassword(
          _emailController.text.trim(),
           _passwordController.text.trim(),
        );
        // User registration successful, navigate back to chat screen
        Navigator.of(context).pop();
      } catch (e) {
        // Handle registration errors
        print('Failed to register user: $e');
        // Display error message to the user (e.g., using a SnackBar)
      }
    }

    Future<void> _signInWithGoogle() async {
      try {
        final GoogleSignInAccount? googleSignInAccount =
            await googleSignIn.signIn();
        if (googleSignInAccount != null) {
          // Sign in with Google successful, obtain Google authentication credentials
          final GoogleSignInAuthentication googleSignInAuth =
              await googleSignInAccount.authentication;
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuth.accessToken,
            idToken: googleSignInAuth.idToken,
          );
          // Sign in with the obtained Google authentication credentials
          await auth.signInWithCredential(credential);
          // Authentication successful, navigate back to chat screen
          Navigator.of(context).pop();
        } else {
          // Google Sign-In canceled by user
          print('Google Sign-In canceled by user');
        }
      } catch (e) {
        // Handle Google Sign-In errors
        print('Failed to sign in with Google: $e');
        // Display error message to the user (e.g., using a SnackBar)
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _signInWithEmailAndPassword,
                child: Text('Sign In'),
              ),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: _registerUserWithEmailAndPassword,
                child: Text('Register with Email'),
              ),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: _signInWithGoogle,
                child: Text('Sign In with Google'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
