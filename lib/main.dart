import 'package:flutter/material.dart';
import 'package:task.im/Helpers/Navigation.dart';
import 'Style/theme.dart' as Theme;
import 'Pages/Home/HomePage.dart';
import 'Pages/LoginPage.dart';
import 'selectprofpic.dart';
import 'Pages/Listings/ExploreListings.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  MyApp() {
    Navigation.initPaths();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: <String, WidgetBuilder>{
        '/landingpage': (BuildContext context) => new MyApp(),
        '/homepage': (BuildContext context) => new HomePage(),
        '/selectpic': (BuildContext context) => new SelectprofilepicPage(),
        '/explore': (BuildContext context) => new ExploreListings()
      },
      onGenerateRoute: Navigation.router.generator,
    );
  }
}
