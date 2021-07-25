import 'package:flutter/material.dart';
import 'package:notes_app/utilities/note_util.dart' as NoteUtil;
import 'package:notes_app/values/my_colors.dart';
import 'package:notes_app/values/strings.dart';

class CreateNoteScreen extends StatefulWidget {
  @override
  _CreateNoteScreenState createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.colorPrimary,
        title: Text(Strings.createNoteTitle),
      ),
      backgroundColor: MyColors.colorBackground,
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
