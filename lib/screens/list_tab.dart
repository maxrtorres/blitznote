import 'package:flutter/material.dart';
import 'package:notes_app/values/my_colors.dart';

class ListTab extends StatefulWidget {
  @override
  _ListTabState createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.colorLight,
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Container(
            height: 50,
            color: MyColors.colorPrimary,
            child: const Center(child: Text('Entry 1')),
          ),
          Container(
            height: 50,
            color: MyColors.colorDark,
            child: const Center(child: Text('Entry 2')),
          ),
          Container(
            height: 50,
            color: MyColors.colorPrimary,
            child: const Center(child: Text('Entry 3')),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        backgroundColor: MyColors.colorDark,
      ),
    );
  }
}
