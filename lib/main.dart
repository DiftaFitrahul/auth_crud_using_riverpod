import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_firebase_riverpod/firebase_options.dart';
import 'package:learn_firebase_riverpod/page/auth_checker.dart';
import 'package:learn_firebase_riverpod/page/create_user.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AuthChecker(),
      routes: {
        CreateUser.routeName : (context) => const CreateUser()
      },
    );
  }
}