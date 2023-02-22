import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_firebase_riverpod/page/home_page.dart';
import 'package:learn_firebase_riverpod/page/login_page.dart';
import 'package:learn_firebase_riverpod/providers/auth_provider.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user != null) {
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
      error: (error, stackTrace) => const LoginPage(),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
