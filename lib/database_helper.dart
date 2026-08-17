

import 'package:path/path.dart';
import 'package:phonebook/contact_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper._internal();

  DatabaseHelper._internal();


  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
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

  Future<void> _createDatabase(Database db,
      int version,) async {
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


//Push Contact

  Future <int> insertContact(Contact contact) async {
    final db = await database;
    return await db.insert('contacts', contact.toMap(),);
  }

//Read Shobar Numbers
  Future<List<Contact>> getContacts() async {
    final db = await database;
    final result = await db.query(
      'contacts',
      orderBy: 'id DESC',
    );
    return result.map((map) => Contact.fromMap(map)).toList();
  }

//Update Contact

  Future<int> updateContact(Contact contact) async {
    final db = await database;
    return await db.update(
      'contacts',
      contact.toMap(),
      where: 'id =?',
      whereArgs: [contact.id],
    );
  }

/*Delete Contacts*/

  Future<int> deleteContact(int id) async {
    final db = await database;
    return await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

//Adding Favourite Contacts (Starred)
  Future<int> updateFavourite(int id,
      bool isFavourite,) async {
    final db = await database;
    return await db.update(
      'contacts',
      { 'isFavourite': isFavourite ? 1 : 0,},
      where: 'id=?',
      whereArgs: [id],
    );
  }


  //Read Favourites
  Future<List<Contact>> getFavorites() async {
    final db = await database;
    final result = await db.query(
      'contacts',
      where: 'isFavourite=?',
      whereArgs: [1],
      orderBy: 'name ASC',
    );

    return result.map((map) => Contact.fromMap(map)).toList();
  }

  Future<List<Contact>> searchContacts(String queryName) async {
    final db = await database;
    final result = await db.query(
      'contacts',
      where: 'name LIKE ?',
      whereArgs: ['%$queryName%'],
      orderBy: 'name ASC',
    );
    return result.map((map) => Contact.fromMap(map)).toList();
  }
}