import 'package:flutter/material.dart';
import 'package:notes_app/utilities/storage_util.dart' as StorageUtil;
import 'package:notes_app/values/keys.dart';
import 'package:notes_app/values/my_colors.dart';
import 'package:notes_app/values/strings.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final usernameController = TextEditingController();

  @override
  void dispose() {
    final name = usernameController.text;
    if (name != '' && name.trim() != '') {
      StorageUtil.setString(Keys.username, name);
    }
    usernameController.dispose();
    super.dispose();
  }

  void initializeFields() async {
    usernameController.text = await StorageUtil.getString(Keys.username) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    initializeFields();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.colorPrimary,
        title: Text(Strings.settingsTitle),
      ),
      backgroundColor: MyColors.colorLight,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          margin: EdgeInsets.all(20),
          child: TextField(
            controller: usernameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: Strings.username,
            ),
          ),
        ),
      ]),
    );
  }
}
