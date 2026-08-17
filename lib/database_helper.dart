

import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper._internal();
  DatabaseHelper._internal();


  Database? _database;
  Future<Database> get database async{
    if (_database != null){
      return _database!;
  }


    _database = await _initDatabase();
      return _database!;
    }


    Future<Database> _initDatabase() async {
      final databasesPath = await getDatabasesPath();
      final path = join(databasesPath, 'contact_manager.db');
      return await openDatabase(
          path,
          version: 1,
          onCreate: _createDatabase,
      );
    }

      Future<void> _createDatabase(
      Database db,
          int version,)
          async {
            await db.execute(
                '''
          CREATE TABLE contacts (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT null,
          phone TEXT NOT null,
          email TEXT,
          address TEXT,
          isFavourite INTEGER DEFAULT 0
          )
          ''');
          }
}