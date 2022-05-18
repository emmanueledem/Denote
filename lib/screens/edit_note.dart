import 'package:flutter/material.dart';
import 'package:mobbit/core/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditNote extends StatefulWidget {
  const EditNote({Key? key}) : super(key: key);
  static const id = 'EditNote';

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
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
                                          // var snackBar = SnackBar(
                                          //   backgroundColor: appColour,
                                          //   duration:
                                          //       const Duration(seconds: 5),
                                          //   content: Text(
                                          //     dishprovider.updateResponse
                                          //         .toString(),
                                          //     style: const TextStyle(
                                          //         color: Colors.white),
                                          //   ),
                                          // );
                                          // Scaffold.of(context)
                                          //     // ignore: deprecated_member_use
                                          //     .showSnackBar(snackBar);
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
