import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/auth_services.dart';

final authServiceProvider = Provider<AuthServices>(
  (ref) => AuthServices(FirebaseAuth.instance),
);

final authStateProvider = StreamProvider<User?>(
    (ref) => ref.read(authServiceProvider).authStateChanges);

