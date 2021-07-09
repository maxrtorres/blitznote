import 'package:flutter/material.dart';
import 'package:notes_app/values/my_colors.dart';
import 'package:notes_app/values/strings.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: MyColors.colorLight,
          endDrawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: MyColors.colorAccent,
                  ),
                  child: Text('Drawer'),
                ),
                ListTile(
                  title: Text('Profile'),
                  onTap: () {},
                ),
                ListTile(
                  title: Text('Settings'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          appBar: AppBar(
            backgroundColor: MyColors.colorPrimary,
            title: Text(Strings.appBarTitle),
          ),
          body: TabBarView(children: [
            Tab(icon: Icon(Icons.list)),
            Tab(icon: Icon(Icons.search)),
            Tab(icon: Icon(Icons.lightbulb)),
            Tab(icon: Icon(Icons.share)),
          ]),
          bottomNavigationBar: Material(
            color: MyColors.colorDark,
            child: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.list)),
                Tab(icon: Icon(Icons.search)),
                Tab(icon: Icon(Icons.lightbulb)),
                Tab(icon: Icon(Icons.share)),
              ],
            ),
          ),
        ));
  }
}
