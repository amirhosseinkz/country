import 'package:sqflite/sqflite.dart';

import 'dart:io';



class DatabaseHelper {
  //table informations
  static final databaseName = "database.db";
  static final countryTable = "countryTable";
  static final version = 1;
  static final columnId = "id";
  static final columnCountryId = "countryId";
  static final columnCountryName = "countryName";

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDatabase();
      return _database;
    }
  }

//initial database
  Future<Database> initDatabase() async {
    Directory directory =
        await Directory.fromUri(Uri.parse(await getDatabasesPath()));

    String path = directory.path + databaseName;
    return await openDatabase(path, version: version, onCreate: _onCreate);
  }

//create database
  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $countryTable('
            '$columnId INTEGER PRIMARY KEY AUTOINCREMENT ,'
        ' $columnCountryId INTEGER ,'
        ' $columnCountryName TEXT );');
  }

//insert function
 static Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return db.insert(countryTable, row);
  }

//sort ascending
  Future<List<Map<String, dynamic>>> sortASC(String column) async {
    Database db = await instance.database;
    return await db
        .rawQuery('SELECT * FROM $countryTable ORDER BY $column ASC;');
  }

//sort descending
  Future<List<Map<String, dynamic>>> sortDESC(String column) async {
    Database db = await instance.database;
    return await db
        .rawQuery('SELECT * FROM $countryTable ORDER BY $column DESC;');
  }

//get all records from database
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(countryTable);
  }

//delete record from database
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return db.delete(countryTable, where: '$columnId = ?', whereArgs: [id]);
  }

//update record in database
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db
        .update(countryTable, row, where: '$columnId = ?', whereArgs: [id]);
  }

//get record by id
  Future<List<Map<String, dynamic>>> getById(int id) async {
    Database db = await instance.database;

    return db.query(countryTable, where: '$columnId = ?', whereArgs: [id]);
  }
}
