import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_firebase_riverpod/providers/auth_provider.dart';
import 'package:learn_firebase_riverpod/vm/signin_state.dart';

class LoginController extends StateNotifier<LoginState> {
  LoginController(this.ref) : super(const LoginStateInitial());

  final Ref ref;

  void signIn(String email, String password) async {
    state = const LoginStateLoading();
    await Future.delayed(const Duration(seconds: 5));
    try {
      await ref
          .read(authServiceProvider)
          .signInWithEmailandPassword(email, password);
      state = const LoginStateSuccess();
    } catch (e) {
      state = LoginStateError(e.toString());
    }
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>(
        (ref) => LoginController(ref));
