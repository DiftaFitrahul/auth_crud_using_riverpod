import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_firebase_riverpod/vm/login_controller.dart';
import 'package:learn_firebase_riverpod/vm/login_state.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> key = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

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
                    ElevatedButton(
                        onPressed: () {
                          if (!key.currentState!.validate()) {
                            return;
                          }
                          ref.read(loginControllerProvider.notifier).signIn(
                              emailController.text, passwordController.text);
                        },
                        child: const Text('Login')),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
