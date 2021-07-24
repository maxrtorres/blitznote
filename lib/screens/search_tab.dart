import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/values/keys.dart';
import 'package:notes_app/values/my_colors.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
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
                subtitle: new Text(note.body),
              )),
        ).toList(),
      ),
    );
  }
}
