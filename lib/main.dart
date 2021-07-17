import 'package:flutter/material.dart';
import 'package:notes_app/screens/home_screen.dart';
import 'package:notes_app/screens/settings_screen.dart';
import 'package:notes_app/values/routes.dart';
import 'package:notes_app/values/strings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Strings.appTitle,
        home: HomeScreen(),
        routes: {
          Routes.homeRoute: (context) => HomeScreen(),
          Routes.settingsRoute: (context) => SettingsScreen(),
        });
  }
}
