import 'package:flutter/material.dart';
import 'package:notes_app/model/note.dart';
import 'package:notes_app/values/my_colors.dart';

class ListTab extends StatefulWidget {
  @override
  _ListTabState createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  getNotes() async {}

  storeNotes() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.colorLight,
      body: new ListView(
        scrollDirection: Axis.vertical,
        children: notes
            .map((note) => new ListTile(
                  title: new Text(note.title),
                  onTap: () {},
                ))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            notes.add(new Note('foo', 'bar'));
          });
        },
        child: const Icon(Icons.add),
        backgroundColor: MyColors.colorDark,
      ),
    );
  }
}
