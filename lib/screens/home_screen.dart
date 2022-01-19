import 'package:flutter/material.dart';
import 'package:notes_app/screens/list_tab.dart';
import 'package:notes_app/screens/search_tab.dart';
import 'package:notes_app/values/my_colors.dart';
import 'package:notes_app/values/routes.dart';
import 'package:notes_app/values/strings.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: MyColors.colorBackground,
          endDrawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                    decoration: BoxDecoration(
                      color: MyColors.colorDrawerHeader,
                    ),
                    child: Container()),
                ListTile(
                  title: Text(Strings.settingsTitle),
                  onTap: () {
                    Navigator.pushNamed(context, Routes.settingsRoute);
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            backgroundColor: MyColors.colorPrimary,
            title: Text(Strings.homeTitle),
          ),
          body: TabBarView(children: [
            ListTab(),
            SearchTab(),
          ]),
          bottomNavigationBar: Material(
            color: MyColors.colorTabs,
            child: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.edit)),
                Tab(icon: Icon(Icons.search)),
              ],
            ),
          ),
        ));
  }
}
