import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import '../models/person.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'personas.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE persons (
        id TEXT PRIMARY KEY,
        firstName TEXT,
        lastName TEXT,
        email TEXT,
        street TEXT,
        imageUrl TEXT,
        rating REAL,
        city TEXT,
        state TEXT,
        postcode TEXT,
        phone TEXT,
        latitude REAL,
        longitude REAL
      )
    ''');
  }

  Future<void> insertPerson(Person person) async {
    final db = await database;
    await db.insert('persons', person.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Person>> getPersons() async {
    final db = await database;
    final result = await db.query('persons');
    return result.map((map) => Person.fromMap(map)).toList();
  }

  Future<int> countPersons() async {
    final db = await database;
    final x = await db.rawQuery('SELECT COUNT(*) as count FROM persons');
    return Sqflite.firstIntValue(x) ?? 0;
  }

  Future<void> deleteAllPersons() async {
    final db = await database;
    await db.delete('persons');
  }
}
