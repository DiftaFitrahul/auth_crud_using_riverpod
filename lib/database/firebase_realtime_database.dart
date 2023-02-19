import 'package:firebase_database/firebase_database.dart';

class RealtimeDatabase {
  final DatabaseReference _database;

  RealtimeDatabase(this._database);

  DatabaseReference get database => _database;

  
}
