import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:task.im/Helpers/CustomBottomAppBar.dart';
import 'HomePage_ListingsTab.dart';
import 'HomePage_MapTab.dart';
import 'package:task.im/Style/theme.dart' as Theme;
import 'package:task.im/services/ListingManager.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ListingManager manager = ListingManager();
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
      key: _scaffoldKey,
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
        onPressed: () {
          manager.AddListing({
            'User': "Test User",
            'Lat': "24.334459",
            'Lon': "54.510480",
            'Title': "Some random Title " + DateTime.now().day.toString(),
            'Description':
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ... The first word, “Lorem,” isn't even a word; instead it's a piece of the word “dolorem,” meaning pain, suffering, or sorrow."
          }).then((result) {
            showInSnackBar(result.toString());
          }).catchError((e) {
            print(e);
          });
        },
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

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: Theme.Fonts.quickBoldFont),
      ),
      //backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }
}
