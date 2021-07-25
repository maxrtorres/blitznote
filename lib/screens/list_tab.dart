import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/model/note.dart';
import 'package:notes_app/values/keys.dart';
import 'package:notes_app/values/my_colors.dart';
import 'package:notes_app/values/routes.dart';

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
    var box = await Hive.openBox(Keys.box);
    List<dynamic> newNotes;
    try {
      newNotes = box.get(Keys.notes);
    } catch (e) {
      return;
    }
    setState(() {
      notes = newNotes;
    });
  }

  storeNotes() async {
    var box = await Hive.openBox(Keys.box);
    box.put(Keys.notes, notes);
  }

  showDeleteDialog(String title, String id) {
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
            setState(() {
              notes.removeWhere((element) => element.uuid == id);
            });
            storeNotes();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.colorBackground,
      body: new ListView(
        scrollDirection: Axis.vertical,
        children: ListTile.divideTiles(
          context: context,
          tiles: notes.map((note) => new ListTile(
                title: new Text(note.title, style: TextStyle(fontSize: 20)),
                subtitle: new Text(note.body, style: TextStyle(fontSize: 15)),
                onTap: () async {
                  final result = await Navigator.pushNamed(
                      context, Routes.editNoteRoute,
                      arguments: note);
                  if (result == null) {
                    return;
                  }
                  final newNote = result as Note;
                  setState(() {
                    note.title = newNote.title;
                    note.body = newNote.body;
                  });
                  storeNotes();
                },
                onLongPress: () {
                  showDeleteDialog(note.title, note.uuid);
                },
              )),
        ).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result =
              await Navigator.pushNamed(context, Routes.createNoteRoute);
          if (result == null) {
            return;
          }
          setState(() {
            notes.add(result);
          });
          storeNotes();
        },
        child: const Icon(Icons.add),
        backgroundColor: MyColors.colorTabs,
      ),
    );
  }
}
