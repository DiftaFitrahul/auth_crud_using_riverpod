import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Type {
  signIn,
  signUp,
}

class AuthenticationType extends StateNotifier<Type> {
  AuthenticationType() : super(Type.signIn);

  void signIn() {
    state = Type.signIn;
  }

  void signUp() {
    state = Type.signUp;
  }
}

final authTypeProvider = StateNotifierProvider<AuthenticationType, Type>(
    (ref) => AuthenticationType());
