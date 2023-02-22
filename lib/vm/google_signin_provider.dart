import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_firebase_riverpod/providers/auth_provider.dart';

class GoogleSignIn extends StateNotifier<bool> {
  GoogleSignIn(this.ref) : super(false);
  final Ref ref;
  void signInGoogle() async {
    try {
      state = true;
      await ref.read(authServiceProvider).signInWithGoogle();
     
      state = false;
    } catch (e) {
      print("Error ================================ $e");
    }
  }
}

final googleSignInProvider = StateNotifierProvider<GoogleSignIn, dynamic>(
  (ref) => GoogleSignIn(ref),
);
