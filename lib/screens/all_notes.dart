import 'package:denote/core/constants/images.dart';
import 'package:denote/services/providers/note_provider.dart';
import 'package:denote/widgets/error_alert.dart';
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
    var notesData = Provider.of<NotesProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
                width: 40,
                height: 40,
                image: AssetImage(Appset.appLogo)),
            Text(
              'Denote',
              style: TextStyle(color: Colors.black, fontFamily: 'VarelaRound'),
            ),
          ],
        ),
        actions: [
          notesData.availableNote.isEmpty
              ? PopupMenuButton(
                  icon: const Icon(Icons.more_horiz),
                  itemBuilder: (context) {
                    return const [
                      PopupMenuItem(
                        value: 'addNote',
                        child: Text('Add Note'),
                      ),
                    ];
                  },
                  onSelected: (String value) {
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
                    if (value == 'newest') {
                      notesData.getNotesAllNotes();
                    } else if (value == 'oldest') {
                      notesData.orderNotes();
                    } else if (value == 'deleteAll') {
                      errorAlertMessage(context, () {
                        notesData.deletAlleNote();
                        Navigator.pop(context);
                      });
                    }
                  },
                ),
        ],
      ),
      body: notesData.ifcomplete == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : notesData.availableNote.isEmpty
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
              : GridView.builder(
                  itemCount: notesData.availableNote.length,
                  itemBuilder: (BuildContext ctx, index) {
                    final Map item = notesData.availableNote[index];
                    return NoteBox(
                      id: item['id'],
                      noteTitle: item['title'],
                      noteDescription: item['description'],
                      dateAdded: item['time'],
                      colorCode: stringToColor(item['colorCode']),
                    );
                  },
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pushNamed(context, Routes.createNote);
        },
      ),
    );
  }
}
