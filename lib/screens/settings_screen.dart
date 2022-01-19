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
  final nameController = TextEditingController();

  @override
  void dispose() {
    final name = nameController.text;
    if (name != '' && name.trim() != '') {
      StorageUtil.setString(Keys.name, name);
    }
    nameController.dispose();
    super.dispose();
  }

  void initializeFields() async {
    nameController.text = await StorageUtil.getString(Keys.name) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    initializeFields();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.colorPrimary,
        title: Text(Strings.settingsTitle),
      ),
      backgroundColor: MyColors.colorBackground,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          margin: EdgeInsets.all(20),
          child: TextField(
            controller: nameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: Strings.name,
            ),
          ),
        ),
      ]),
    );
  }
}
