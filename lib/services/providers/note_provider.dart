import 'dart:math';
import 'package:denote/model/db.config.dart';
import 'package:denote/model/notes.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class NotesProvider extends ChangeNotifier {
  Color? colorCode;
  List availableNote = [];
  bool ifcomplete = true;

  void colorPicker() {
    int number = Random().nextInt(5) + 1;
    if (number == 2) {
      colorCode = const Color.fromARGB(255, 169, 240, 171);
    } else if (number == 3) {
      colorCode = const Color.fromARGB(255, 243, 239, 28);
    } else if (number == 4) {
      colorCode = const Color.fromARGB(255, 223, 96, 57);
    } else if (number == 5) {
      colorCode = const Color.fromARGB(255, 118, 56, 146);
    }
    notifyListeners();
  }

  late DatabaseHelper dbHelper;

  Future<int> addNote(Notes note) async {
    dbHelper = DatabaseHelper();
    await dbHelper.initDB();
    int result = await dbHelper.db.insert(tableNotes, note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    notifyListeners();
    return result;
  }

  Future<List<Notes>> getNotesAllNotes() async {
    dbHelper = DatabaseHelper();
    await dbHelper.initDB();
    final List<Map<String, dynamic>> queryResponse = await dbHelper.db.query(
      tableNotes,
      orderBy: "id DESC",
    );
    availableNote = queryResponse;
    ifcomplete = false;

    notifyListeners();
    return queryResponse.map((e) => Notes.fromMap(e)).toList();
  }

  Future<void> editNote(Notes note) async {
    dbHelper = DatabaseHelper();
    await dbHelper.initDB();
    await dbHelper.db.update(tableNotes, note.toMap(),
        where: "id = ?", whereArgs: [note.id]);
    await getNotesAllNotes();
    notifyListeners();
  }

  Future<void> deleteNote(id) async {
    dbHelper = DatabaseHelper();
    await dbHelper.initDB();
    await dbHelper.db.delete(tableNotes, where: "id = ?", whereArgs: [id]);
    await getNotesAllNotes();
    notifyListeners();
  }

  Future<List<Notes>> orderNotes() async {
    dbHelper = DatabaseHelper();
    await dbHelper.initDB();
    final List<Map<String, dynamic>> queryResponse = await dbHelper.db.query(
      tableNotes,
      orderBy: "id ASC",
    );
    availableNote = queryResponse;
    notifyListeners();
    return queryResponse.map((e) => Notes.fromMap(e)).toList();
  }

  Future<void> deletAlleNote() async {
    dbHelper = DatabaseHelper();
    await dbHelper.initDB();
    await dbHelper.db.delete(tableNotes);
    await getNotesAllNotes();
    notifyListeners();
  }
}
