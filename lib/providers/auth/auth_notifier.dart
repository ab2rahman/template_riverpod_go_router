import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<User?> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthNotifier() : super(null) {
    // Listen to authentication state changes
    _auth.authStateChanges().listen((User? user) {
      state = user;
    });
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> registerUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signInWithCredential(AuthCredential credential) async {
    try {
      await _auth.signInWithCredential(credential);
    } catch (error) {
      rethrow;
    }
  }
}
