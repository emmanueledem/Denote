import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobbit/core/navigators/navigators.dart';
import 'package:mobbit/model/notes.dart';
import 'package:mobbit/services/providers/notes_provider.dart';
import 'package:mobbit/widgets/error_alert.dart';
import 'package:mobbit/widgets/note.dart';
import 'package:provider/provider.dart';

class AllTask extends StatefulWidget {
  const AllTask({Key? key}) : super(key: key);
  @override
  State<AllTask> createState() => _AllTaskState();
}

class _AllTaskState extends State<AllTask> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await _handleAllNotes();
    });
    super.initState();
  }

  Future _handleAllNotes() async {
    Provider.of<NotesProvider>(context, listen: false).getNotes();
  }

  @override
  Widget build(BuildContext context) {
    var allNotes = Provider.of<NotesProvider>(context, listen: true);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.note_add_rounded,
                color: Colors.blue,
              ),
              Text(
                'Mobbit',
                style:
                    TextStyle(color: Colors.black, fontFamily: 'VarelaRound'),
              ),
            ],
          ),
          actions: [
            allNotes.noteList.isEmpty
                ? PopupMenuButton(
                    icon: const Icon(Icons.more_horiz),
                    itemBuilder: (context) {
                      return const [
                        PopupMenuItem(
                          value: 'Add Note',
                          child: Text('Add Note'),
                        ),
                      ];
                    },
                    onSelected: (String value) {
                      allNotes.deleteAllNotes();
                      Navigator.pushNamed(context, Routes.createNote);
                    },
                  )
                : PopupMenuButton(
                    icon: const Icon(Icons.more_horiz),
                    itemBuilder: (context) {
                      return const [
                        PopupMenuItem(
                          value: 'newest',
                          child: Text('Sort By Newest'),
                        ),
                        PopupMenuItem(
                          value: 'oldest',
                          child: Text('Sort By Oldest'),
                        ),
                        PopupMenuItem(
                          value: 'deleteAll',
                          child: Text('Clear All Notes'),
                        )
                      ];
                    },
                    onSelected: (String value) {
                      value == 'deleteAll'
                          ? errorAlertMessage(context, () {
                              allNotes.deleteAllNotes();
                            })
                          : allNotes.sortNotes(value);
                    },
                  ),
          ],
        ),
        body: allNotes.noteList.isEmpty
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.mode_edit,
                          size: 40,
                          color: Colors.blue,
                        ),
                        Expanded(
                          child: Text(
                            'When you add note\'s they will all appear here.',
                            style: TextStyle(
                                fontFamily: 'VarelaRound', fontSize: 20.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Stack(
                children: [
                  GridView.builder(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2),
                    itemCount: allNotes.noteList.length,
                    itemBuilder: (context, index) {
                      Notes note = allNotes.noteList[index];   
                      
                      var finalDate =  
                          DateFormat.yMEd().add_jms().format(note.dateAdded);
                      return Note(
                        noteTitle: note.noteTitle,
                        noteDescription: note.noteDescription,
                        dateAdded: finalDate.toString(),
                        colorCode:  Color(0xffdf6039),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 10),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue)),
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.createNote);
                        },
                        child: const Text('+ Add Note',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'VarelaRound',
                                color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ));
  }
}
