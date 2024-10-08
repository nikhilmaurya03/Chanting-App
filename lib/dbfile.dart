import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class CountDatabase {
  //variables
  static const dbName = "myDatabase.db";
  static const dbVersion = 1;
  static const dbTable = "myTable";

  //table
  static const columnId = "id";
  static const columnDate = "date";
  static const columnCount = "count";

  //object
  static final CountDatabase instance = CountDatabase();

  //database initialise
  static Database? _database;

  Future<Database?> get database async {
    _database ??= await initDB();
    return _database;
  }

  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    return await openDatabase(path, version: dbVersion, onCreate: onCreate);
  }

  Future onCreate(Database db, int version) async {
    db.execute('''
     CREATE TABLE $dbTable(
     $columnId INTEGER PRIMARY KEY,
     $columnDate TEXT NOT NULL,
     $columnCount INTEGER NOT NULL)
  ''');
  }

  //insert method
  insertRecord(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(dbTable, row);
  }
 

  //read database
  Future<List<Map<String, dynamic>>> readDatabase() async {
    Database? db = await instance.database;
    return await db!.query(dbTable);
  }

  //update record

  Future<int> updateRecord(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[columnId];
    return await db!.update(dbTable, row, where: '$columnId = ?', whereArgs: [id]);
  }

    //delete method

  Future<int> deleteRecord(int id) async {
    Database? db = await instance.database;
    return await db!.delete(dbTable, where: '$columnId = ?', whereArgs: [id]);
  }
}
