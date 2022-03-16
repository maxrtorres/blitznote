import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/utilities/biometric_util.dart';
import 'package:notes_app/values/keys.dart';
import 'package:notes_app/values/my_colors.dart';
import 'package:notes_app/values/routes.dart';
import 'package:notes_app/values/strings.dart';

eraseData() async {
  var box = await Hive.openBox(Keys.box);
  box.clear();
  unEnrollBiometrics();
}

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
      backgroundColor: MyColors.colorBackground,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            margin: EdgeInsets.all(20),
            child: Center(
                child: TextButton(
              onPressed: () {
                AlertDialog alert = AlertDialog(
                  title: Text(
                      'Are you sure you want to clear app data? This will erase all of your notes.'),
                  actions: [
                    TextButton(
                      child: Text("Cancel"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text("Clear",
                          style: TextStyle(color: MyColors.redColor)),
                      onPressed: () {
                        eraseData();
                        Navigator.pushReplacementNamed(
                            context, Routes.initialRoute);
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
              },
              child: Text("Clear App Data", style: TextStyle(fontSize: 20)),
            ))),
      ]),
    );
  }
}
