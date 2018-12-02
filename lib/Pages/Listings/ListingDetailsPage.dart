import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task.im/Helpers/Dashboard_Helper.dart';
import 'package:task.im/Style/Style.dart' as Theme;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task.im/services/ListingManager.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import 'package:task.im/Helpers/ListingHelpers.dart';
import 'dart:math' as math;
import 'package:task.im/Pages/Listings/ListingDetailsPage.dart';

class ListingDetailsPage extends StatefulWidget {
  final listing;
  final int index;

  const ListingDetailsPage({Key key, this.listing, this.index})
      : super(key: key);
  _ListingDetailsPageState createState() =>
      _ListingDetailsPageState(this.listing, this.index);
}

class _ListingDetailsPageState extends State<ListingDetailsPage> {
  Size deviceSize;
  var manager = ListingManager();

  ScrollController _scrollController = new ScrollController();

  _ListingDetailsPageState(listing, int index);

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
                        TitleBarRegion(),
                        PhotosRegion(context),
                        DescriptionRegion(context),
                        MapRegion(context),
                        Header(context, "Similar Listings"),
                        FeaturedListings()

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

  SliverPersistentHeader PhotosRegion(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _SliverAppBarDelegate(
          minHeight: 150,
          maxHeight: 150,
          child: Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Card(
              elevation: 3,
            ),
          )),
    );
  }

  SliverPersistentHeader DescriptionRegion(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _SliverAppBarDelegate(
          minHeight: 150,
          maxHeight: 150,
          child: Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Card(
              elevation: 3,
            ),
          )),
    );
  }

  SliverPersistentHeader MapRegion(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _SliverAppBarDelegate(
          minHeight: 150,
          maxHeight: 150,
          child: Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Card(
              elevation: 3,
            ),
          )),
    );
  }

  SliverPersistentHeader TitleBarRegion() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 125.0,
        maxHeight: 125.0,
        child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Hero(
                tag: "ListingTag" + widget.index.toString(),
                child: Card(
                  elevation: 3.0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          widget.listing.data["Title"],
                          style: TextStyle(
                              fontFamily: Theme.Fonts.ralewayFont,
                              fontWeight: FontWeight.w700),
                        ),
                        Divider(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.locationArrow,
                                      size: 10,
                                    ),
                                    Text(
                                      "  " +
                                          widget.listing.data["Lat"] +
                                          " KM away",
                                      style: TextStyle(
                                          fontFamily: Theme.Fonts.ralewayFont,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.calendar,
                                      size: 10,
                                    ),
                                    Divider(
                                      height: 29,
                                    ),
                                    Text(
                                      "  " +
                                          widget.listing.data["Lat"] +
                                          " Days Before",
                                      style: TextStyle(
                                          fontFamily: Theme.Fonts.ralewayFont,
                                          fontSize: 10),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  widget.listing.data["Renumeration"],
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.lightGreen,
                                      fontFamily: Theme.Fonts.quickFont,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
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
        maxHeight: 150.0,
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
                                    ? Icons.arrow_back
                                    : Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                          // new DashboardTitle(
                          //   title: "Task.im",
                          //   textColor: Colors.white,
                          // ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new IconButton(
                            icon: new Icon(
                              FontAwesomeIcons.heart,
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
