import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/model/note.dart';
import 'package:notes_app/values/my_colors.dart';
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

showDeleteDialog(
    String title, String id, BuildContext context, Function deleteCallback) {
  AlertDialog alert = AlertDialog(
    title: Text('Delete \"$title\"?'),
    actions: [
      TextButton(
        child: Text("Cancel"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      TextButton(
        child: Text("Delete", style: TextStyle(color: MyColors.redColor)),
        onPressed: () {
          deleteCallback(id);
          Navigator.of(context).pop();
        },
      ),
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
