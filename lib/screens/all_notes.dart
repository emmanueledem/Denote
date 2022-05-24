import 'package:denote/widgets/note.dart';
import 'package:flutter/material.dart';

import '../core/navigators/navigators.dart';

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
    // Provider.of<NotesProvider>(context, listen: false).getNotes();
  }

  @override
  Widget build(BuildContext context) {
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
            PopupMenuButton(
              icon: const Icon(Icons.more_horiz),
              itemBuilder: (context) {
                return const [
                  PopupMenuItem(
                    value: 'Add Note',
                    child: Text('Add Note'),
                  ),
                ];
              },
              onSelected: (String value) {},
            )
            //  PopupMenuButton(
            //     icon: const Icon(Icons.more_horiz),
            //     itemBuilder: (context) {
            //       return const [
            //         PopupMenuItem(
            //           value: 'newest',
            //           child: Text('Sort By Newest'),
            //         ),
            //         PopupMenuItem(
            //           value: 'oldest',
            //           child: Text('Sort By Oldest'),
            //         ),
            //         PopupMenuItem(
            //           value: 'deleteAll',
            //           child: Text('Clear All Notes'),
            //         )
            //       ];
            //     },
            //     onSelected: (String value) {

            //     },
            //   ),
          ],
        ),
        body:
            //  Padding(
            //     padding:
            //         const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
            //     child: Center(
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Row(
            //           children: const [
            //             Icon(
            //               Icons.mode_edit,
            //               size: 40,
            //               color: Colors.blue,
            //             ),
            //             Expanded(
            //               child: Text(
            //                 'When you add note\'s they will all appear here.',
            //                 style: TextStyle(
            //                     fontFamily: 'VarelaRound', fontSize: 20.0),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   )
            Stack(
          children: [
            GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              // gridDelegate:
              //     const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              //
              // ),

              children: [
                Note(
                  noteTitle: 'The Note Title',
                  noteDescription: 'The description',
                  dateAdded: '12/July/2022',
                  colorCode: Color.fromRGBO(223, 96, 57, 1),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 10),
              child: Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
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
