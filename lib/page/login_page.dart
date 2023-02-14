import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _key = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
              key: _key,
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
                            (value!.isNotEmpty && value.length > 6)
                                ? null
                                : 'password is invalid'),
                    ElevatedButton(
                        onPressed: () {
                          if (!_key.currentState!.validate()) {
                            return;
                          }
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(
                                const SnackBar(content: Text('Succes Login')));
                        },
                        child: const Text('Login'))
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
