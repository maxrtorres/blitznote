import 'package:flutter/material.dart';
import 'package:notes_app/model/note.dart';
import 'package:notes_app/utilities/note_util.dart' as NoteUtil;
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
              onPressed: () {
                NoteUtil.saveNote(
                    context, titleController.text, bodyController.text);
              },
              child: Text(Strings.save, style: TextStyle(fontSize: 20))),
        ],
      )),
    );
  }
}
