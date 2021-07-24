import 'package:flutter/material.dart';
import 'package:notes_app/screens/list_tab.dart';
import 'package:notes_app/utilities/storage_util.dart' as StorageUtilities;
import 'package:notes_app/values/keys.dart';
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
          backgroundColor: MyColors.colorLight,
          endDrawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: MyColors.colorAccent,
                  ),
                  child: FutureBuilder<dynamic>(
                    future: StorageUtilities.getString(Keys.username),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      String username;
                      if (snapshot.data != null) {
                        username = snapshot.data;
                      } else {
                        username = Strings.defaultUsername;
                      }
                      return Center(
                          child: Text('Welcome, $username!',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)));
                    },
                  ),
                ),
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
            Tab(icon: Icon(Icons.search)),
          ]),
          bottomNavigationBar: Material(
            color: MyColors.colorDark,
            child: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.list)),
                Tab(icon: Icon(Icons.search)),
              ],
            ),
          ),
        ));
  }
}
