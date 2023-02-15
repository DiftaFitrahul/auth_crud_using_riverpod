import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Type {
  signIn,
  signUp,
  googleSignIn,
}

class AuthenticationType extends StateNotifier<Type> {
  AuthenticationType() : super(Type.signIn);

  void signIn() {
    state = Type.signIn;
  }

  void signUp() {
    state = Type.signUp;
  }

  void googleSignIn() {
    state = Type.googleSignIn;
  }
}

final authTypeProvider = StateNotifierProvider<AuthenticationType, Type>(
    (ref) => AuthenticationType());
