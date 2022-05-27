import 'package:denote/screens/edit_note.dart';
import 'package:denote/services/providers/note_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class ViewNote extends StatefulWidget {
  const ViewNote({Key? key, this.id}) : super(key: key);
  final int? id;

  @override
  State<ViewNote> createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  @override
  Widget build(BuildContext context) {
    var notesData = Provider.of<NotesProvider>(context);
    Logger().d(widget.id);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 169, 240, 171),
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: const Color.fromARGB(255, 169, 240, 171),
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
              //  var noteProvider =
              //      Provider.of<NotesProvider>(context, listen: false);
              //  value == 'delete'
              //      ? await noteProvider.deleteNote(id)
              //      : Navigator.pushNamed(context, Routes.editNote,
              //          arguments: EditNote(
              //            id: id,
              //          ));
              //  Logger().d(id);
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
            children: const [
              Text(
                'My first Note',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'VarelaRound',
                    fontSize: 25.0),
              ),
              Text(
                '12/4/2012 19:45 PM',
                style: TextStyle(fontSize: 14.0),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                ' An fassara daga Ingilishi-A cikin wallafe-wallafe da ƙira mai hoto, Lorem ipsum rubutun wuri ne da aka saba amfani da shi don nuna sigar gani na takarda ko nau in rubutu ba tare da dogaro da abun ciki mai maana ba. Ana iya amfani da Lorem ipsum azaman mai riƙewa kafin a sami kwafin ƙarshe',
                style: TextStyle(
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
