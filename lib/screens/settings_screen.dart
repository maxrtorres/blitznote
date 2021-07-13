import 'package:flutter/material.dart';
import 'package:notes_app/values/my_colors.dart';
import 'package:notes_app/values/strings.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.colorPrimary,
          title: Text(Strings.settingsTitle),
        ),
        backgroundColor: MyColors.colorLight,
        body: Container());
    Center(child: Text('Settings'));
  }
}
