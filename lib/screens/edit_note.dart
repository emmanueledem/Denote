import 'package:denote/model/notes.dart';
import 'package:denote/services/providers/note_provider.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../core/constants/styles.dart';

class EditNote extends StatefulWidget {
  const EditNote({Key? key, required this.notes}) : super(key: key);
  final Notes notes;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final TextEditingController _noteTitle =
        TextEditingController(text: widget.notes.title);
    final TextEditingController _noteBody =
        TextEditingController(text: widget.notes.description);
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.edit,
                color: Colors.blue,
              ),
              Text(
                'Edit Note',
                style:
                    TextStyle(color: Colors.black, fontFamily: 'VarelaRound'),
              ),
            ],
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
                                  controller: _noteTitle,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
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
                                      fontWeight: FontWeight.bold,
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
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          });
                                          var notesData =
                                              Provider.of<NotesProvider>(
                                                  context,
                                                  listen: false);
                                          await notesData.editNote(Notes(
                                              id: widget.notes.id,
                                              title: _noteTitle.text,
                                              description: _noteBody.text,
                                              time: widget.notes.time,
                                              colorCode:
                                                  widget.notes.colorCode));
                                          Navigator.pop(context);
                                        }
                                      },
                                      minWidth: 365,
                                      height: 51,
                                      textColor: Colors.white,
                                      color: Colors.blue,
                                      child: const Text(
                                        'Save Changes',
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
