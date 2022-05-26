import 'package:denote/model/notes.dart';
import 'package:denote/services/providers/note_provider.dart';
import 'package:denote/widgets/note.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/navigators/navigators.dart';
import '../utils/format_color.dart';

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
    Provider.of<NotesProvider>(context, listen: false).getNotesAllNotes();
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
                'Denote',
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
        // Padding(
        //               padding: const EdgeInsets.symmetric(
        //                   vertical: 100, horizontal: 50),
        //               child: Center(
        //                 child: Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child: Row(
        //                     children: const [
        //                       Icon(
        //                         Icons.mode_edit,
        //                         size: 40,
        //                         color: Colors.blue,
        //                       ),
        //                       Expanded(
        //                         child: Text(
        //                           'When you add note\'s they will all appear here.',
        //                           style: TextStyle(
        //                               fontFamily: 'VarelaRound',
        //                               fontSize: 20.0),
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             );
        body: Consumer<NotesProvider>(builder: (context, notesData, child) {
          return Stack(
            children: [
              FutureBuilder(
                future: notesData.getNotesAllNotes(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Notes>> snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext ctx, index) {
                        final item = snapshot.data![index];
                        return NoteBox(
                          id: item.id!.toInt(),
                          noteTitle: item.title.toString(),
                          noteDescription: item.description.toString(),
                          dateAdded: item.time.toString(),
                          colorCode: stringToColor(item.colorCode),
                        );
                      },
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                 
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
          );
        }));
  }
}
