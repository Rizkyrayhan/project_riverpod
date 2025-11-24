import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/legacy.dart';

class AuthNotifier extends StateNotifier<User?> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthNotifier() : super(null) {
    _auth.authStateChanges().listen((user) {
      state = user;
    });
  }

  Stream<User?> get streamAuthStatus => _auth.authStateChanges();

  Future<String?> login(String email, String pass) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      return null; // null = sukses
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "Email tidak ditemukan.";
      } else if (e.code == 'wrong-password') {
        return "Password salah.";
      } else {
        return e.message;
      }
    }
  }
  Future<void> logout() async {
    await _auth.signOut();
  } 
}


final authProvider = StateNotifierProvider<AuthNotifier, User?>(
  (ref) => AuthNotifier(),
);
