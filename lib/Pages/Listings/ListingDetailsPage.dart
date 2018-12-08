import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:task.im/Helpers/Dashboard_Helper.dart';
import 'package:task.im/Style/Style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task.im/services/ListingManager.dart';
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
                        DescriptionRegion(),
                        MapRegion(context),
                        PhotosRegion(context),
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

  SliverList DescriptionRegion() {
    return SliverList(
        delegate: SliverChildListDelegate([
      Padding(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Text(
                    "TASK DESCRIPTION",
                    style: Fonts.S2,
                    textAlign: TextAlign.center,
                  ),
                ),
                Divider(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 30),
                  child: Text(
                    widget.listing.data["Description"] +
                        widget.listing.data["Description"],
                    // style: Fonts.S2,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            )),
      )
    ]));
  }

  SliverList MapRegion(BuildContext context) {
    double lat = double.tryParse(widget.listing.data["Lat"]);
    double lon = double.tryParse(widget.listing.data["Lon"]);

    if (lat != null && lon != null) {
      return SliverList(
        delegate: SliverChildListDelegate([
          Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 3,
              child: Container(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    child: GoogleMap(
                      options: GoogleMapOptions(
                        cameraPosition: CameraPosition(
                            target: LatLng(lat, lon), zoom: 12.0),
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        controller.addMarker(
                            MarkerOptions(position: LatLng(lat, lon)));
                      },
                    ),
                  )),
            ),
          )
        ]),
      );
    } else {
      return SliverList(delegate: SliverChildListDelegate([]));
    }
  }

  SliverPersistentHeader TitleBarRegion() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
          minHeight: 115.0,
          maxHeight: 205.0,
          child: SafeArea(
            top: true,
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Hero(
                    tag: "ListingTag" + widget.index.toString(),
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 3,
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                    height: 61,
                                    child: Text(
                                      //widget.listing.data["Title"],
                                      "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAa",
                                      maxLines: 3,
                                      softWrap: true,
                                      style: Fonts.T1,
                                    ),
                                    alignment: Alignment(0, 0),
                                  )),
                                  //VerticalDivider(),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          widget.listing.data["Renumeration"],
                                          style: Fonts.N1,
                                        ),
                                        Divider(
                                          height: 4,
                                        ),
                                        Text(
                                          "NEGOTIABLE",
                                          style: Fonts.S2,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Divider(
                                height: 30,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(FontAwesomeIcons.star),
                                        Divider(
                                          height: 20,
                                        ),
                                        Text(
                                          "SKILL LEVEL 1",
                                          style: Fonts.S3,
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                  VerticalDivider(),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(FontAwesomeIcons.calendarAlt),
                                        Divider(
                                          height: 20,
                                        ),
                                        Text(
                                          "POSTED 5 DAYS BEFORE",
                                          style: Fonts.S3,
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                  VerticalDivider(),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(FontAwesomeIcons.mapMarkedAlt),
                                        Divider(
                                          height: 20,
                                        ),
                                        Text(
                                          "WITH IN 50 KILOMETERS",
                                          style: Fonts.S3,
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )))),
          )),
    );
  }

  SliverPersistentHeader AppBarRegion(BuildContext context) {
    return SliverPersistentHeader(
      pinned: false,
      delegate: _SliverAppBarDelegate(
        minHeight: 84.0,
        maxHeight: 220.0,
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
