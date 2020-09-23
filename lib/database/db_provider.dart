import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  Database _database;
  Future<Database> get database async {
    if (_database == null) {
      _database = await _initialize();
    }
    return _database;
  }

  void dispose() {
    _database?.close();
    _database = null;
  }

  Future<Database> _initialize() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    String path = join(docDir.path, 'budget_tracker');
    Database db = await openDatabase(path, version: 1, onOpen: (db) {
      print('Database Open');
    },onCreate: _onCreate,);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE Account("
        "id INTEGER PRIMARY KEY,"
        "name TEXT,"
        "codePoint INTEGER,"
        "balance REAL"
        ")");
  }
}
