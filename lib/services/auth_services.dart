import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth;

  AuthServices(this._auth);

  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  Future<User?> signInWithEmailandPassword(
      String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
