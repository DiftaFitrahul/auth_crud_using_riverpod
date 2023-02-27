import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final FirebaseAuth _auth;
  final _googleSignIn = GoogleSignIn.standard();

  AuthServices(this._auth);

  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  User? get user => FirebaseAuth.instance.currentUser;

  Future<User?> signInWithEmailandPassword(
      String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleAccount!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    try {
      final result = await _auth.signInWithCredential(credential);
      return result.user;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await Future.wait([_auth.signOut(), _googleSignIn.signOut()]);
    } catch (e) {
      rethrow;
    }
  }
}
