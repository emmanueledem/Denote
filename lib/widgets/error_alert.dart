import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

errorAlertMessage(BuildContext context, onpressed) {
  return Alert(
    context: context,
    type: AlertType.warning,
    title: 'Confirm Action',
    desc: 'Do you want to clear all notes',
    buttons: [
      DialogButton(
        child: const Text(
          "Yes",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: onpressed,
        width: 120,
      ),
      DialogButton(
        child: const Text(
          "No",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        width: 120,
      )
    ],
  ).show();
}
