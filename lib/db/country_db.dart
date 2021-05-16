// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:flutter_appq/model/country_model.dart';
// import 'package:get/get.dart';
//
//
//
// class CountryDataBase {
//   static final List<String> values = [
//     columnId , columnCountryId , columnCountryName
//   ];
//   static final databaseName = "database.db";
//   static final countryTable = "countryTable";
//   static final version = 1;
//   static final columnId = "id";
//   static final columnCountryId = "countryId";
//   static final columnCountryName = "countryName";
//
//   static final CountryDataBase instance =
//       CountryDataBase._init();
//
//   static Database _database;
//
//   CountryDataBase._init();
//
//
//   Future<Database> get database async{
//     if (_database != null) return _database;
//
//     _database = await _initDB(databaseName);
//     return _database;
//   }
//
//   Future<Database> _initDB(String filePath) async{
//     final dbPath = await getDatabasesPath(
//
//     );
//     final path = join(dbPath , filePath);
//
//     return await openDatabase(path , version: 1,
//     onCreate: _createDB);
//   }
//
//   Future _createDB(Database db , int version) async {
//   //
//   //   final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
//   //   final textType = 'TEXT NOT NULL';
//   //   final integerType = 'INTEGER NOT NULL';
//   //
//   //   await db.execute('''
//   //   CREATE TABLE $tableCountry(
//   //   ${CountryFields.id} $idType,
//   //   ${CountryFields.countryId} $integerType,
//   //   ${CountryFields.name} $textType,
//   //   )
//   //   ''');
//   // }
//
//     db.execute(
//         'CREATE TABLE $countryTable('
//             '$columnId INTEGER PRIMARY KEY AUTOINCREMENT ,'
//             ' $columnCountryId INTEGER ,'
//             ' $columnCountryName TEXT );');
//   }
//
//   Future<CountryModel> create(CountryModel countryModel) async{
//     final db = await instance.database;
//     final id = await db.insert(countryTable, countryModel.toJson());
//     return countryModel.copy(id: id);
//   }
//
//   Future<CountryModel> readCountry(int id)async {
//     final db = await instance.database;
//
//     final maps = await db.query(
//       countryTable,
//       columns: CountryDataBase.values,
//       where: '${CountryDataBase.columnId} = ?' ,
//       whereArgs: [id],
//     );
//     if (maps.isNotEmpty) {
//       return CountryModel.fromJson(maps.first);
//       }else {
//       throw Exception('ID $id not found');
//     }
//   }
//
//   Future<List<CountryModel>> readAllNotes() async{
//     final db = await instance.database;
//
//
//     final result = await db.query(countryTable);
//
//     return result.map((json) => CountryModel.fromJson(json)).toList();
//
//   }
//
//   Future<int> update(CountryModel countryModel) async{
//     final db = await instance.database;
//
//     return db.update(countryTable,countryModel.toJson(),
//     where: '${CountryDataBase.columnId} = ?',
//     whereArgs: [countryModel.id],
//     );
//   }
//
//   Future<int> delete(int id) async {
//     final db = await instance.database;
//
//     return await db.delete(
//       countryTable,
//       where: '${CountryDataBase.columnId} = ?',
//       whereArgs: [id],
//     );
//   }
//
//   Future close() async {
//     final db = await instance.database;
//
//     db.close();
//   }
// }