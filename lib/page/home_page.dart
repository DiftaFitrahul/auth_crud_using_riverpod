import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_firebase_riverpod/page/create_user.dart';
import 'package:learn_firebase_riverpod/page/read_user.dart';
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
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, CreateUser.routeName);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: const ReadPage());
  }
}
