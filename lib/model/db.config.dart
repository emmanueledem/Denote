import 'dart:async';
import 'package:denote/model/notes.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();

  AppDatabase._init();

  static Database? _database;

  // open a connection
  Future<Database?> get database async {
    if (_database != null) return _database!;

    _database = await initDB('notes.db');
    return _database;
  }

  initDB(String filepath) async {
    String dbPath = getDatabasesPath() as String;
    final path = join(dbPath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future _createDb(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE $tableNotes 
      ${NoteFields.id} $idType,
      ${NoteFields.title} $textType,
      ${NoteFields.description} $textType,
      ${NoteFields.colorCode} $textType,
''');
  }
}
