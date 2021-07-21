import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/model/note.dart';
import 'package:notes_app/values/strings.dart';

void saveNote(context, title, body) {
  if (title == '' || title.trim() == '') {
    Fluttertoast.showToast(
        msg: Strings.nullTitleError,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16.0);
    return;
  }

  if (body == '' || body.trim() == '') {
    Fluttertoast.showToast(
        msg: Strings.nullBodyError,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16.0);
    return;
  }

  Navigator.pop(context, new Note(title, body));
}
