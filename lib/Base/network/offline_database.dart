import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class OfflineDatabase {
  static const String _databaseName = 'musaeid.db';
  static const int _databaseVersion = 1;
  static const String _tableName = 'orderTable';

  static Database? _database;

  /// Initialize the database
  static Future<void> initDatabase() async {
    if (_database != null) return;

    String dbPath = await getDatabasesPath();
    String path = join(dbPath, _databaseName);

    _database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id TEXT PRIMARY KEY,
            json TEXT NOT NULL
          )
        ''');
      },
    );
  }

  /// Save object in the database
  static Future<void> saveObject<T>(
      T object,
      Map<String, dynamic> Function(T) toJson,
      {required String idField}) async {
    await initDatabase();

    // Convert the object to a JSON string
    Map<String, dynamic> jsonMap = toJson(object);
    String jsonString = jsonEncode(jsonMap);

    print(" jsonMap[idField] : ${jsonMap[idField]} ,jsonString : ${jsonString}");
    // Insert the JSON string into the database with the id
    await _database?.insert(
      _tableName,
      {'id': jsonMap[idField], 'json': jsonString},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    print("saveObject done");
  }



/*  /// Retrieve object from the database
  static Future<T?> getObject<T>(
      String key,
      T Function(Map<String, dynamic>) fromJson,
      ) async {
    await initDatabase();

    final List<Map<String, dynamic>> result = await _database!.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [key],
    );

    print("result : ${result}");
    if (result.isEmpty) return null;

    String jsonString = result.first['json'] as String;
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    print("getObject done");
    return fromJson(jsonMap);
  }*/

  /// Retrieve an object from the database by its ID.
  static Future<T?> getObject<T>(
      String id,
      T Function(Map<String, dynamic>) fromJson,
      ) async {
    await initDatabase();
print("getObject id : ${id}");
    // Query the database for the record with the given ID
    final List<Map<String, dynamic>> result = await _database!.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    print("Query result: $result");

    // If no records are found, return null
    if (result.isEmpty) return null;

    // Get the JSON string of the first matching record
    String jsonString = result.first['json'] as String;

    // Decode the JSON string into a Map
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    print("getObject done");

    // Convert the Map into an object of type T and return it
    return fromJson(jsonMap);
  }





  /// Remove object from the database
  static Future<void> removeObject(String key) async {
    await initDatabase();

    await _database?.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [key],
    );
  }

  /// Close the database
  static Future<void> closeDatabase() async {
    await _database?.close();
    _database = null;
  }
}
