import 'package:denote/core/navigators/navigators.dart';
import 'package:denote/model/notes.dart';
import 'package:denote/services/providers/note_provider.dart';
import 'package:denote/utils/format_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewNote extends StatefulWidget {
  const ViewNote({
    Key? key,
    required this.notes,
  }) : super(key: key);

  final Notes notes;

  @override
  State<ViewNote> createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  @override
  Widget build(BuildContext context) {
    Color color = stringToColor(widget.notes.colorCode);
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: color,
        elevation: 0,
        title: const Text(
          'Read Note',
          style: TextStyle(color: Colors.black, fontFamily: 'VarelaRound'),
        ),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_horiz),
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit Note'),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete Note'),
                )
              ];
            },
            onSelected: (String value) async {
              var noteProvider =
                  Provider.of<NotesProvider>(context, listen: false);
              if (value == 'delete') {
                await noteProvider.deleteNote(widget.notes.id);
                Navigator.pop(context);
              } else {
                Navigator.pushNamed(context, Routes.editNote,
                    arguments: Notes(
                      id: widget.notes.id,
                      title: widget.notes.title,
                      description: widget.notes.description,
                      time: widget.notes.time,
                      colorCode: widget.notes.colorCode,
                    ));
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.notes.title.toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'VarelaRound',
                    fontSize: 25.0),
              ),
              Text(
                widget.notes.time.toString(),
                style: const TextStyle(fontSize: 14.0),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.notes.description.toString(),
                style: const TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'VarelaRound',
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        )),
      ),
    );
  }
}
