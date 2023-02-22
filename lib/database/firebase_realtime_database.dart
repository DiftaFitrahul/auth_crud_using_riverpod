import 'package:firebase_database/firebase_database.dart';
import 'package:learn_firebase_riverpod/models/data_food.dart';

class RealtimeDatabase {
  final DatabaseReference _database;

  RealtimeDatabase(this._database);

  DatabaseReference get database => _database;

  Stream<List<Food>> fetchData(String userId) {
    try {
      final dataFood = _database.child("orders/$userId").onValue;
      final streamData = dataFood.map((event) {
        final dataMap = Map<String, dynamic>.from(event.snapshot.value as Map);
        final dataList = dataMap.entries.map((data) {
          final food = Map<String, dynamic>.from(data.value as Map);
          food['itemId'] = data.key;
          return Food.fromRTDB(food);
        }).toList();
        return dataList;
      });
      return streamData;
    } catch (e) {
      rethrow;
    }
  }
}
