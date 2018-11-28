import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:task.im/Helpers/CustomBottomAppBar.dart';
import 'HomePage_ListingsTab.dart';
import 'HomePage_MapTab.dart';
import 'package:task.im/Style/theme.dart' as Theme;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  var profilePicUrl =
      'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg';

  var nickName = 'User Name';
  var email = "Email Address";

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        profilePicUrl = user.photoUrl;
        nickName = user.displayName;
        email = user.email;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text(nickName),
                accountEmail: new Text(email),
                currentAccountPicture: new CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(profilePicUrl),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Theme.Colors.loginGradientStart,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // bottomNavigationBar: new CustomBottomAppBar(
      //   color: Colors.white,
      //   fabLocation: FloatingActionButtonLocation.endDocked,
      //   shape: CircularNotchedRectangle(),
      // ),
      // bottomNavigationBar: new Material(
      //   color: Colors.teal,
      //   child: TabBar(
      //     controller: tabController,
      //     tabs: <Widget>[
      //       new Tab(icon: Icon(Icons.home)),
      //       new Tab(icon: Icon(Icons.map)),
      //     ],
      //   ),
      // ),
      body: new TabBarView(
        controller: tabController,
        children: <Widget>[HomePage_ListingsTab(), HomePage_MapTab()],
      ),
    );
  }
}
