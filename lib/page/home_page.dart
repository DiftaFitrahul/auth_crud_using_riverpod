import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_firebase_riverpod/page/create_user.dart';
import 'package:learn_firebase_riverpod/providers/auth_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page '),
          leading: IconButton(
              onPressed: () async {
                
                await ref.read(authServiceProvider).signOut();
              },
              icon: const Icon(Icons.logout_outlined)),
        ),
        body: const CreateUser());
  }
}
