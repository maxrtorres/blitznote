import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/model/note.dart';
import 'package:notes_app/screens/create_note_screen.dart';
import 'package:notes_app/screens/edit_note_screen.dart';
import 'package:notes_app/screens/home_screen.dart';
import 'package:notes_app/screens/initial_screen.dart';
import 'package:notes_app/screens/settings_screen.dart';
import 'package:notes_app/values/routes.dart';
import 'package:notes_app/values/strings.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NoteAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Strings.homeTitle,
        home: InitialScreen(),
        routes: {
          Routes.initialRoute: (context) => InitialScreen(),
          Routes.homeRoute: (context) => HomeScreen(),
          Routes.settingsRoute: (context) => SettingsScreen(),
          Routes.createNoteRoute: (context) => CreateNoteScreen(),
          Routes.editNoteRoute: (context) => EditNoteScreen(),
        });
  }
}
