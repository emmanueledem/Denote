import 'dart:async';
import 'package:denote/model/notes.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._();

  DatabaseHelper._();

  late Database db;

  Future<void> initDB() async {
    String path = await getDatabasesPath();

    db = await openDatabase(
      join(path, 'notesDB.db'),
      onCreate: (database, version) async {
        const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
        const textType = 'TEXT NOT NULL';
        await database.execute(
          """
           CREATE TABLE $tableNotes (
       ${NoteFields.id} $idType,
       ${NoteFields.title} $textType,
       ${NoteFields.description} $textType,
       ${NoteFields.time} $textType,
       ${NoteFields.colorCode} $textType)
          """,
        );
      },
      // CREATE TABLE users (
      //         id INTEGER PRIMARY KEY AUTOINCREMENT,
      //         name TEXT NOT NULL,
      //         age INTEGER NOT NULL,
      //         email TEXT NOT NULL
      //       )

      version: 1,
    );
  }

  factory DatabaseHelper() {
    return _databaseHelper;
  }
}
