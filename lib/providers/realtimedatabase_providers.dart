import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/firebase_realtime_database.dart';
import '../models/data_food.dart';

final databaseProvider = Provider<RealtimeDatabase>(
  (ref) => RealtimeDatabase(FirebaseDatabase.instance.ref()),
);

final realtimeDatabaseProvider = Provider<DatabaseReference>(
  (ref) => RealtimeDatabase(FirebaseDatabase.instance.ref()).database,
);

final streamFoodProvider = StreamProvider.autoDispose.family<List<Food>, String>(
    (ref, userId) => ref.read(databaseProvider).fetchData(userId));


