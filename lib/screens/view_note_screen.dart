import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/model/note.dart';
import 'package:notes_app/values/my_colors.dart';
import 'package:notes_app/values/strings.dart';

class ViewNoteScreen extends StatefulWidget {
  @override
  _ViewNoteScreenState createState() => _ViewNoteScreenState();
}

class _ViewNoteScreenState extends State<ViewNoteScreen> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    bodyController.dispose();
  }

  void saveNote() {
    final title = titleController.text;
    final body = bodyController.text;

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

  @override
  Widget build(BuildContext context) {
    final note = ModalRoute.of(context)?.settings.arguments as Note;
    titleController.text = note.title;
    bodyController.text = note.body;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.colorPrimary,
        title: Text(Strings.viewNoteTitle),
      ),
      backgroundColor: MyColors.colorLight,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: Strings.title,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: TextField(
              controller: bodyController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: Strings.body,
              ),
            ),
          ),
          TextButton(
              onPressed: saveNote,
              child: Text(Strings.save, style: TextStyle(fontSize: 20))),
        ],
      )),
    );
  }
}
