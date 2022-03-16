import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/model/note.dart';
import 'package:notes_app/utilities/note_util.dart';
import 'package:notes_app/values/keys.dart';
import 'package:notes_app/values/my_colors.dart';
import 'package:notes_app/values/routes.dart';
import 'package:notes_app/values/strings.dart';

class ListTab extends StatefulWidget {
  final bool isSearch;
  ListTab({required this.isSearch});

  @override
  _ListTabState createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  List<dynamic> notes = [];
  List<dynamic> queryResult = [];
  String curSearch = "";

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
      if (widget.isSearch) {
        queryResult = newNotes;
      }
    });
  }

  void deleteCallback(String id) {
    setState(() {
      notes.removeWhere((element) => element.uuid == id);
      if (widget.isSearch) {
        queryResult.removeWhere((element) => element.uuid == id);
      }
    });
    storeNotes();
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

  void storeNotes() async {
    var box = await Hive.openBox(Keys.box);
    box.put(Keys.notes, notes);
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> displayNotes;
    if (widget.isSearch) {
      displayNotes = queryResult;
    } else {
      displayNotes = notes;
    }

    return Scaffold(
      backgroundColor: MyColors.colorBackground,
      body: Column(children: [
        Visibility(
          visible: widget.isSearch,
          child: TextField(
            onChanged: (value) {
              curSearch = value;
              filter(value);
            },
            decoration: InputDecoration(
                labelText: Strings.search, suffixIcon: Icon(Icons.search)),
          ),
        ),
        Expanded(
          child: new ListView(
            scrollDirection: Axis.vertical,
            children: ListTile.divideTiles(
              context: context,
              tiles: displayNotes.map((note) => new ListTile(
                    title: new Text(note.title, style: TextStyle(fontSize: 20)),
                    subtitle:
                        new Text(note.body, style: TextStyle(fontSize: 15)),
                    onTap: () async {
                      final result = await Navigator.pushNamed(
                          context, Routes.createNoteRoute,
                          arguments: note);
                      if (result == null) {
                        return;
                      }
                      final newNote = result as Note;
                      setState(() {
                        note.title = newNote.title;
                        note.body = newNote.body;
                      });
                      if (widget.isSearch) {
                        filter(curSearch);
                      }
                      storeNotes();
                    },
                    onLongPress: () {
                      showDeleteDialog(
                          note.title, note.uuid, context, deleteCallback);
                    },
                  )),
            ).toList(),
          ),
        )
      ]),
      floatingActionButton: Visibility(
        visible: !widget.isSearch,
        child: FloatingActionButton(
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
      ),
    );
  }
}
