import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_firebase_riverpod/providers/auth_provider.dart';
import 'package:learn_firebase_riverpod/vm/signup_state.dart';

class SignupController extends StateNotifier<SignupState> {
  SignupController(this.ref) : super(const SignupStateInitial());
  final Ref ref;

  Future<void> signUp(String email, String password) async {
    state = const SignupStateLoading();
    try {
      await ref
          .watch(authServiceProvider)
          .signUpWithEmailAndPassword(email, password);
      state = const SignupStateSuccess();
    } catch (e) {
      state = SignupStateError(e.toString());
    }
  }
}

final signupControllerProvider =
    StateNotifierProvider<SignupController, SignupState>(
        (ref) => SignupController(ref));
