import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task.im/ui/page/dashboard/dashboard_one/dashboard_menu_row.dart';
import 'package:task.im/ui/widgets/login_background.dart';
import 'package:task.im/ui/widgets/profile_tile.dart';
import 'package:task.im/Style/theme.dart' as Theme;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage_ListingsTab extends StatelessWidget {
  Size deviceSize;
  Widget appBarColumn(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 18.0),
          child: new Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new IconButton(
                      icon: new Icon(
                        defaultTargetPlatform == TargetPlatform.android
                            ? Icons.menu
                            : Icons.menu,
                        color: Colors.white,
                      ),
                      onPressed: () => Scaffold.of(context).openDrawer()),
                  new ProfileTile(
                    title: "Task.im",
                    subtitle: "I'm Possibility",
                    textColor: Colors.white,
                  ),
                  new IconButton(
                    icon: new Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      print("hi");
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      );

  Widget searchCard() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 10.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.search),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Find Tasks near me"),
                  ),
                ),
                Icon(Icons.my_location),
              ],
            ),
          ),
        ),
      );

  Widget actionMenuCard() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  DashboardMenuRow(
                    firstIcon: FontAwesomeIcons.solidUser,
                    firstLabel: "Carpentery",
                    firstIconCircleColor: Colors.blue,
                    secondIcon: FontAwesomeIcons.userFriends,
                    secondLabel: "Masonary",
                    secondIconCircleColor: Colors.orange,
                    thirdIcon: FontAwesomeIcons.mapMarkerAlt,
                    thirdLabel: "Delivery",
                    thirdIconCircleColor: Colors.purple,
                    fourthIcon: FontAwesomeIcons.locationArrow,
                    fourthLabel: "Electrical",
                    fourthIconCircleColor: Colors.indigo,
                  ),
                  // DashboardMenuRow(
                  //   firstIcon: FontAwesomeIcons.images,
                  //   firstLabel: "Albums",
                  //   firstIconCircleColor: Colors.red,
                  //   secondIcon: FontAwesomeIcons.solidHeart,
                  //   secondLabel: "Likes",
                  //   secondIconCircleColor: Colors.teal,
                  //   thirdIcon: FontAwesomeIcons.solidNewspaper,
                  //   thirdLabel: "Articles",
                  //   thirdIconCircleColor: Colors.lime,
                  //   fourthIcon: FontAwesomeIcons.solidCommentDots,
                  //   fourthLabel: "Reviews",
                  //   fourthIconCircleColor: Colors.amber,
                  // ),
                  DashboardMenuRow(
                    firstIcon: FontAwesomeIcons.footballBall,
                    firstLabel: "Coding",
                    firstIconCircleColor: Colors.cyan,
                    secondIcon: FontAwesomeIcons.solidStar,
                    secondLabel: "Random",
                    secondIconCircleColor: Colors.redAccent,
                    thirdIcon: FontAwesomeIcons.blogger,
                    thirdLabel: "Misc",
                    thirdIconCircleColor: Colors.pink,
                    fourthIcon: FontAwesomeIcons.wallet,
                    fourthLabel: "Charity",
                    fourthIconCircleColor: Colors.brown,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget balanceCard() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Task",
                      style: TextStyle(fontFamily: Theme.Fonts.ralewayFont),
                    ),
                    Material(
                      color: Colors.black,
                      shape: StadiumBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "500 Meters",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: Theme.Fonts.ralewayFont),
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  "₹ 1000",
                  style: TextStyle(
                      fontFamily: Theme.Fonts.ralewayFont,
                      fontWeight: FontWeight.w700,
                      color: Colors.green,
                      fontSize: 25.0),
                ),
              ],
            ),
          ),
        ),
      );

  Widget allCards(BuildContext context) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            appBarColumn(context),
            SizedBox(
              height: deviceSize.height * 0.01,
            ),
            searchCard(),
            SizedBox(
              height: deviceSize.height * 0.01,
            ),
            actionMenuCard(),
            SizedBox(
              height: deviceSize.height * 0.01,
            ),
            balanceCard(),
            balanceCard(),
            balanceCard(),
            balanceCard(),
            balanceCard(),
            balanceCard(),
            balanceCard(),
            balanceCard(),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          LoginBackground(
            showIcon: false,
          ),
          allCards(context),
        ],
      ),
    );
  }
}
