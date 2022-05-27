import 'package:denote/model/notes.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../core/constants/styles.dart';
import '../services/providers/note_provider.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({Key? key}) : super(key: key);
  static const id = 'CreateNote';

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _noteTitle = TextEditingController();
  final TextEditingController _noteBody = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Create Note',
            style: TextStyle(color: Colors.black, fontFamily: 'VarelaRound'),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: false,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 25.0,
                          right: 25.0,
                        ),
                        child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  maxLength: 35,
                                  controller: _noteTitle,
                                  style: const TextStyle(
                                      color: Colors.black87,
                                      fontFamily: 'VarelaRound',
                                      height: 1.3),
                                  decoration:
                                      kEditProfileInputDecorationStyle.copyWith(
                                    labelText: 'Note Title',
                                  ),
                                  validator: (String? value) {
                                    return (value == null || value.isEmpty)
                                        ? 'Note Title is required'
                                        : null;
                                  },
                                ),
                                const SizedBox(
                                  height: 18.0,
                                ),
                                TextFormField(
                                  controller: _noteBody,
                                  maxLines: 5,
                                  style: const TextStyle(
                                      color: Colors.black87,
                                      fontFamily: 'VarelaRound',
                                      height: 1.3),
                                  decoration:
                                      kEditProfileInputDecorationStyle.copyWith(
                                    labelText: 'Note Body',
                                  ),
                                  validator: (String? value) {
                                    return (value == null || value.isEmpty)
                                        ? 'Title Body is required'
                                        : null;
                                  },
                                ),
                                const SizedBox(
                                  height: 18.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 20),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: MaterialButton(
                                      onPressed: () async {
                                        var currentTime = DateFormat.yMEd()
                                            .add_jms()
                                            .format(DateTime.now());

                                        var notesProvider =
                                            Provider.of<NotesProvider>(context,
                                                listen: false);
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          });

                                          notesProvider.colorPicker();

                                          await notesProvider.addNote(Notes(
                                              title: _noteTitle.text,
                                              description: _noteBody.text,
                                              time: currentTime,
                                              colorCode: notesProvider.colorCode
                                                  .toString()));
                                          await notesProvider
                                              .getNotesAllNotes();
                                          Navigator.pop(context);
                                          _noteTitle.clear();
                                          _noteBody.clear();
                                        }
                                      },
                                      minWidth: 365,
                                      height: 51,
                                      textColor: Colors.white,
                                      color: Colors.blue,
                                      child: const Text(
                                        'Save Note',
                                        style: TextStyle(
                                            color: Color(
                                              0xffF6F6F9,
                                            ),
                                            fontSize: 17,
                                            fontFamily: 'VarelaRound',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    )
                  ]),
            ),
          ),
        ));
  }
}
