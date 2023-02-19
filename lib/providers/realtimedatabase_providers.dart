import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/firebase_realtime_database.dart';

final realtimeDatabaseProvider = Provider<DatabaseReference>(
  (ref) => RealtimeDatabase(FirebaseDatabase.instance.ref()).database,
);
