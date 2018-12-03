import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task.im/Helpers/CustomBottomAppBar.dart';
import 'package:task.im/Helpers/Navigation.dart';
import 'HomePage_ListingsTab.dart';
import 'HomePage_MapTab.dart';
import 'package:task.im/Style/Style.dart' as Theme;
import 'package:task.im/services/ListingManager.dart';
import 'package:task.im/Pages/Listings/CreateListing.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
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
          Navigation.router.navigateTo(context, '/CreteLisitng',
              transition: TransitionType.fadeIn);
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => CreateListing()));
          // manager.AddListing({
          //   'Date': DateTime.now().toUtc().toIso8601String(),
          //   'TimeStamp': DateTime.now().toUtc().year.toString() +
          //       DateTime.now().toUtc().month.toString() +
          //       DateTime.now().toUtc().day.toString() +
          //       DateTime.now().toUtc().hour.toString() +
          //       DateTime.now().toUtc().minute.toString() +
          //       DateTime.now().toUtc().second.toString() +
          //       math.Random().nextInt(1000).toString(),
          //   'User': "Test User",
          //   'Lat': "24.334459",
          //   'Lon': "54.510480",
          //   'Renumeration': math.Random().nextInt(1000).toString() + " AED",
          //   'Title': "Listing Created at " +
          //       DateTime.now().day.toString() +
          //       DateTime.now().hour.toString() +
          //       DateTime.now().minute.toString(),
          //   'Description':
          //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ... The first word, “Lorem,” isn't even a word; instead it's a piece of the word “dolorem,” meaning pain, suffering, or sorrow."
          // }).then((result) {
          //   showInSnackBar(result.toString());
          // }).catchError((e) {
          //   print(e);
          // });
        },
        child: Ink(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: Theme.Pigments.kitGradients,
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(2.0, 2.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Icon(
                Icons.add,
                color: Colors.white,
              ),

              // builder
            ],
          ),
        ),
        clipBehavior: Clip.antiAlias,
        backgroundColor: Theme.Pigments.loginGradientStart,
        heroTag: "FabTag",
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
        physics: BouncingScrollPhysics(),
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
