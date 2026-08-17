



import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper.internal();
  DatabaseHelper._internal();


  Database? _database;
  Future<Database> get database async{
    if (database != null){
      return _database!;
  }

    _database = await _innitDatabase() asyne{
      final databasesPath = await getDatabasesPath();
      final patch =join(databasesPath, 'contact_manager.db');
      return await openDatabase(
          path,
        version: 1,
        onCreate: _createDatabase;
      );

      Future<void> _createDatabase(
      Database db,
          int version,)
          async {
            await db.execute(
                '''
          CREATE TABLE contacts (
          id INTIGER PRIMARY KEY AUTOINCRIMENT,
          name TEXT NOT null,
          phone TEXT NOT null,
          email TXT,
          address TXT,
          isFavourite INTIGER DEFAULT 0
          )
          ''');
          }



        )



          }
      )

    }




}
}