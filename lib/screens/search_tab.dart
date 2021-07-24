import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/values/keys.dart';
import 'package:notes_app/values/my_colors.dart';
import 'package:notes_app/values/strings.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  List<dynamic> notes = [];
  List<dynamic> queryResult = [];

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
      queryResult = newNotes;
    });
  }

  void filter(value) {
    List<dynamic> newNotes;
    if (value == null || value == '') {
      newNotes = notes;
    } else {
      newNotes = notes
          .where((note) =>
              containsIgnoreCase(note.title, value) ||
              containsIgnoreCase(note.body, value))
          .toList();
    }
    setState(() {
      queryResult = newNotes;
    });
  }

  bool containsIgnoreCase(String str1, String str2) {
    return str1.toLowerCase().contains(str2.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.colorLight,
        body: Column(children: [
          TextField(
            onChanged: (value) => filter(value),
            decoration: InputDecoration(
                labelText: Strings.search, suffixIcon: Icon(Icons.search)),
          ),
          Expanded(
            child: new ListView(
              scrollDirection: Axis.vertical,
              children: ListTile.divideTiles(
                context: context,
                tiles: queryResult.map((note) => new ListTile(
                      title: new Text(note.title),
                      subtitle: new Text(note.body),
                    )),
              ).toList(),
            ),
          )
        ]));
  }
}
