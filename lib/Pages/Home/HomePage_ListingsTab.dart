import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task.im/Helpers/Dashboard_Helper.dart';
import 'package:task.im/Style/theme.dart' as Theme;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task.im/services/ListingManager.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import 'package:task.im/Helpers/ListingHelpers.dart';
import 'dart:math' as math;
import 'package:task.im/Pages/Listings/ListingDetailsPage.dart';

class HomePage_ListingsTab extends StatefulWidget {
  _HomePage_ListingsTabState createState() => _HomePage_ListingsTabState();
}

class _HomePage_ListingsTabState extends State<HomePage_ListingsTab> {
  Size deviceSize;
  var manager = ListingManager();
  List items = new List();
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;
  var _dashbgxpos = -1.0;
  bool animateHeader = false;

  @override
  void initState() {
    manager = new ListingManager();
    manager.FetchDocuments().then((onValue) {
      setState(() {
        items = onValue;
      });
    });

    super.initState();
    _scrollController.addListener(() {
      if (animateHeader &&
          _scrollController.position.pixels < 500 &&
          _scrollController.position.pixels > 0) {
        setState(() {
          _dashbgxpos = _scrollController.position.pixels * -1.2;
          // scrollpos = _scrollController.position.pixels.toString();
        });
      }

      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (!isPerformingRequest) {
          setState(() => isPerformingRequest = true);
          manager.FetchDocumentsFromLast().then((onValue) {
            setState(() {
              items = onValue;
              isPerformingRequest = false;
            });
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned.fill(
                top: _dashbgxpos,
                child: DashboardBackground(
                  showIcon: false,
                ),
              ),
              FutureBuilder(
                future: manager.FetchDocuments(),
                builder: (context, snapshot) {
                  return SafeArea(
                    child: CustomScrollView(
                      controller: _scrollController,
                      physics: BouncingScrollPhysics(),
                      slivers: <Widget>[
                        AppBarRegion(context),
                        SearchBarRegion(),
                        MenuBarRegion(context),
                        Header(context, "Featured Listings"),
                        Listings()

                        // ListingsRegion(),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }

  SliverList Listings() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        if (index == items.length) {
          return _buildProgressIndicator();
        } else {
          return GestureDetector(
            child: ListTile(
              title: ListingTile_Regular(
                  items[index].data["Title"],
                  items[index].data["Description"],
                  "location",
                  items[index].data["Renumeration"],
                  Colors.blue),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListingDetailsPage(
                          listing: items[index],
                        )),
              );
            },
          );
        }
      }, childCount: items.length + 1),
    );
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(20.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new RefreshProgressIndicator(),
        ),
      ),
    );
  }

  SliverGrid FeaturedListings() {
    return SliverGrid.count(
      crossAxisCount: 2,
      childAspectRatio: .9,
      mainAxisSpacing: 5.0,
      children: [
        ListingTile_Square(
            "Title can be as long as it wants! however it will get cut off at some point",
            "Description Goes here",
            "Location",
            '800 USD',
            Colors.grey),
        ListingTile_Square("Title can be as long as it wants!",
            "Description Goes here", "Location", '800 USD', Colors.grey),
        ListingTile_Square("Title can be as long as it wants!",
            "Description Goes here", "Location", '800 USD', Colors.grey),
        ListingTile_Square("Title can be as long as it wants!",
            "Description Goes here", "Location", '800 USD', Colors.grey),
        ListingTile_Square("Title can be as long as it wants!",
            "Description Goes here", "Location", '800 USD', Colors.grey),
        ListingTile_Square("Title can be as long as it wants!",
            "Description Goes here", "Location", '800 USD', Colors.grey),
      ],
    );
  }

  SliverPersistentHeader Header(BuildContext context, String HeaderText) {
    return SliverPersistentHeader(
      delegate: _SliverAppBarDelegate(
          minHeight: 50,
          maxHeight: 50,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
            child: Column(
              children: <Widget>[
                Text(
                  HeaderText,
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black54),
                ),
                Divider()
              ],
            ),
          )),
    );
  }

  SliverPersistentHeader MenuBarRegion(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _SliverAppBarDelegate(
        minHeight: 200,
        maxHeight: 210,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                elevation: 5.0,
                child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            LabelBelowIcon(
                              circleColor: Colors.blue,
                              label: "Electrical",
                              icon: FontAwesomeIcons.plug,
                              onPressed: () {
                                Navigator.of(context).pushNamed('/explore');
                              },
                            ),
                            LabelBelowIcon(
                              circleColor: Colors.orange,
                              label: "Mechanical",
                              icon: FontAwesomeIcons.broadcastTower,
                            ),
                            LabelBelowIcon(
                              circleColor: Colors.purple,
                              label: "Masonary",
                              icon: FontAwesomeIcons.building,
                            ),
                            LabelBelowIcon(
                              circleColor: Colors.deepPurple,
                              label: "Carpentry",
                              icon: FontAwesomeIcons.chair,
                            ),
                          ],
                        ),
                        Divider(
                          height: 25.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            LabelBelowIcon(
                              circleColor: Colors.cyan,
                              label: "Pickup",
                              icon: Icons.location_on,
                            ),
                            LabelBelowIcon(
                              circleColor: Colors.pinkAccent,
                              label: "Ride",
                              icon: Icons.location_on,
                            ),
                            LabelBelowIcon(
                              circleColor: Colors.pink,
                              label: "Art",
                              icon: Icons.location_on,
                            ),
                            LabelBelowIcon(
                              circleColor: Colors.brown,
                              label: "Charity",
                              icon: Icons.location_on,
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  SliverPersistentHeader CategoryBarRegion() {
    return SliverPersistentHeader(
      pinned: false,
      delegate: _SliverAppBarDelegate(
        minHeight: 220.0,
        maxHeight: 75.0,
        child: Column(
          children: <Widget>[
            Padding(
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
            )
          ],
        ),
      ),
    );
  }

  SliverPersistentHeader SearchBarRegion() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 75.0,
        maxHeight: 75.0,
        child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 10.0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
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
            )),
      ),
    );
  }

  SliverPersistentHeader AppBarRegion(BuildContext context) {
    return SliverPersistentHeader(
      pinned: false,
      delegate: _SliverAppBarDelegate(
        minHeight: 108.0,
        maxHeight: 120.0,
        child: Container(
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 18.0),
              child: new Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new IconButton(
                              icon: new Icon(
                                defaultTargetPlatform == TargetPlatform.android
                                    ? Icons.menu
                                    : Icons.menu,
                                color: Colors.white,
                              ),
                              onPressed: () =>
                                  Scaffold.of(context).openDrawer()),
                          new DashboardTitle(
                            title: "Task.im",
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new IconButton(
                            icon: new Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ListingCard(BuildContext context, data) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed("/explore");
          },
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
                        data["Title"],
                        style: TextStyle(fontFamily: Theme.Fonts.quickBoldFont),
                      ),
                    ],
                  ),
                  Text(
                    data["Description"],
                    style: TextStyle(
                      fontFamily: Theme.Fonts.quickFont,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
