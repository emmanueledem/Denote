import 'package:denote/model/notes.dart';
import 'package:denote/screens/view_note.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NoteBox extends StatelessWidget {
  NoteBox({
    Key? key,
    required this.id,
    required this.noteTitle,
    required this.noteDescription,
    required this.dateAdded,
    required this.colorCode,
  }) : super(key: key);

  int id;
  String noteTitle;
  String noteDescription;
  String dateAdded;
  Color colorCode;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewNote(
                      notes: Notes(
                        id: id,
                        title: noteTitle,
                        description: noteDescription,
                        time: dateAdded,
                        colorCode: colorCode.toString(),
                      ),
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
            color: colorCode,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  noteTitle.length > 30
                      ? noteTitle.substring(0, 30) + '...'
                      : noteTitle,
                  style: const TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'VarelaRound',
                      fontWeight: FontWeight.bold),
                ),
                Text(dateAdded.toString()),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  noteDescription.length > 50
                      ? noteDescription.substring(0, 50) + '...'
                      : noteDescription,
                  style: const TextStyle(
                    fontSize: 13.0,
                    fontFamily: 'VarelaRound',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
