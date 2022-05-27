import 'package:flutter/material.dart';

const kEditProfileInputDecorationStyle = InputDecoration(
  fillColor: Colors.grey,
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(13.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
        BorderSide(color: Color.fromARGB(255, 157, 179, 216), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(13.0)),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(13.0)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(13.0)),
  ),
  labelStyle: TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.blue,
    fontFamily: 'poppins',
    fontSize: 16,
  ),
);


//  var finalDate =  
//                           DateFormat.yMEd().add_jms().format(note.dateAdded);
