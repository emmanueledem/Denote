import 'package:denote/screens/edit_note.dart';
import 'package:denote/screens/view_note.dart';
import 'package:denote/services/providers/note_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../core/navigators/navigators.dart';

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
        Navigator.pushNamed(context, Routes.viewNote,
            arguments: ViewNote(id: id));
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
                  noteTitle,
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
