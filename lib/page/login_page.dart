import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_firebase_riverpod/providers/auth_provider.dart';
import 'package:learn_firebase_riverpod/providers/auth_type_providers.dart';
import 'package:learn_firebase_riverpod/vm/google_signin_provider.dart';
import 'package:learn_firebase_riverpod/vm/signin_controller.dart';
import 'package:learn_firebase_riverpod/vm/signin_state.dart';
import 'package:learn_firebase_riverpod/vm/signup_state.dart';

import '../vm/signup_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoadingSignin = ref.watch(loginControllerProvider);
    final isLoadingSignup = ref.watch(signupControllerProvider);
    final authType = ref.watch(authTypeProvider);

    ref.listen<LoginState>(
        loginControllerProvider,
        ((previous, next) => {
              if (next is LoginStateError)
                {
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(next.error)))
                }
            }));
    ref.listen<SignupState>(
        signupControllerProvider,
        ((previous, next) => {
              if (next is SignupStateError)
                {
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(next.error)))
                }
            }));
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
              key: key,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    TextFormField(
                        controller: emailController,
                        decoration:
                            const InputDecoration(hintText: 'email@gmail.com'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            (EmailValidator.validate(value!) &&
                                    value.isNotEmpty)
                                ? null
                                : 'email is invalid'),
                    TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(hintText: 'password'),
                        validator: (value) =>
                            (value!.isNotEmpty && value.length > 5)
                                ? null
                                : 'password is invalid'),
                    if (authType == Type.signUp)
                      TextFormField(
                          controller: confirmPasswordController,
                          decoration: const InputDecoration(
                              hintText: 'confirm password'),
                          validator: (value) => (value!.isNotEmpty &&
                                  value.length > 5 &&
                                  passwordController.text ==
                                      confirmPasswordController.text)
                              ? null
                              : 'password is invalid'),
                    buttonToEnter(authType, isLoadingSignin, isLoadingSignup),
                    SizedBox(
                        height: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                (authType == Type.signIn)
                                    ? ref
                                        .read(authTypeProvider.notifier)
                                        .signUp()
                                    : ref
                                        .read(authTypeProvider.notifier)
                                        .signIn();
                              },
                              child: (authType == Type.signIn)
                                  ? const Text("SignUp")
                                  : const Text("SignIn"),
                            ),
                            const Text('Or'),
                            TextButton(
                                onPressed: () {
                                  ref
                                      .read(googleSignInProvider.notifier)
                                      .signInGoogle();
                                },
                                child: const Text("Sign in with Google"))
                          ],
                        ))
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget buttonToEnter(
    Type type,
    LoginState isLoadingSignin,
    SignupState isLoadingSignup,
  ) {
    if (type == Type.signIn) {
      return (isLoadingSignin is LoginStateLoading)
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (!key.currentState!.validate()) {
                  return;
                }

                ref
                    .read(loginControllerProvider.notifier)
                    .signIn(emailController.text, passwordController.text);
              },
              child: const Text('Login'));
    } else {
      return (isLoadingSignup is SignupStateLoading)
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (!key.currentState!.validate()) {
                  return;
                }

                ref
                    .read(signupControllerProvider.notifier)
                    .signUp(emailController.text, passwordController.text);
              },
              child: const Text('Sign up'));
    }
  }
}
