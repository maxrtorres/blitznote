import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/model/note.dart';
import 'package:notes_app/values/my_colors.dart';

class ListTab extends StatefulWidget {
  @override
  _ListTabState createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  List<dynamic> notes = [];

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  void getNotes() async {
    var box = await Hive.openBox('myBox');
    List<dynamic> newNotes = box.get('notes');
    setState(() {
      notes = newNotes;
    });
  }

  storeNotes() async {
    var box = await Hive.openBox('myBox');
    box.put('notes', notes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.colorLight,
      body: new ListView(
        scrollDirection: Axis.vertical,
        children: ListTile.divideTiles(
          context: context,
          tiles: notes.map((note) => new ListTile(
                title: new Text(note.title),
                onTap: () {
                  print(note.uuid);
                },
              )),
        ).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            notes.add(new Note('foo', 'bar'));
          });
          storeNotes();
        },
        child: const Icon(Icons.add),
        backgroundColor: MyColors.colorDark,
      ),
    );
  }
}
