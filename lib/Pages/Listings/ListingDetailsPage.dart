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
  var map = TempMap();

  ScrollController _scrollController = new ScrollController();

  _ListingDetailsPageState(listing, int index);

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 2)).then((onValue) {
      setState(() {
        map = MapRegion(context);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          color: Pigments.DefaultBg,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned.fill(
                child: DashboardBackground(
                  // image: widget.listing.data["Photos"][0],
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
                        PhotosRegion(context),
                        map,
                        OwnerRegion(),
                        // MapRegion(context),
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
      childAspectRatio: 1,
      mainAxisSpacing: 5.0,
      children: [
        ListingTile_Square(
            "Title can be as long as it wants! however it will get cut off at some point",
            "Description Goes here",
            "Location",
            '800 USD',
            Colors.lightBlueAccent),
        ListingTile_Square(
            "Title can be as long as it wants!",
            "Description Goes here",
            "Location",
            '800 USD',
            Colors.lightBlueAccent),
        ListingTile_Square(
            "Title can be as long as it wants!",
            "Description Goes here",
            "Location",
            '800 USD',
            Colors.lightBlueAccent),
        ListingTile_Square(
            "Title can be as long as it wants!",
            "Description Goes here",
            "Location",
            '800 USD',
            Colors.lightBlueAccent),
        ListingTile_Square(
            "Title can be as long as it wants!",
            "Description Goes here",
            "Location",
            '800 USD',
            Colors.lightBlueAccent),
        ListingTile_Square(
            "Title can be as long as it wants!",
            "Description Goes here",
            "Location",
            '800 USD',
            Colors.lightBlueAccent),
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

  SliverList PhotosRegion(BuildContext context) {
    List<dynamic> pics = widget.listing.data["Photos"];
    if (pics != null) {
      return SliverList(
          delegate: SliverChildListDelegate([
        Padding(
          padding: EdgeInsets.fromLTRB(8, 0, 8, 10),
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
                      "IMAGES",
                      style: Fonts.S2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Divider(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: pics.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: FadeInImage.assetNetwork(
                                height: 150,
                                image: pics[index],
                                placeholder: "",
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              )),
        )
      ]));
    } else {
      return SliverList(
          delegate: SliverChildListDelegate([
        Container(
          height: 2,
        )
      ]));
    }
  }

  SliverList DescriptionRegion() {
    return SliverList(
        delegate: SliverChildListDelegate([
      Padding(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 10),
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
                    "MORE DETAILS",
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
                    widget.listing.data["Description"],
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            )),
      )
    ]));
  }

  SliverList OwnerRegion() {
    return SliverList(
        delegate: SliverChildListDelegate([
      Padding(
        padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 3,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.blue,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "A TASK BY",
                              style: Fonts.S2,
                              textAlign: TextAlign.center,
                            ),
                            Divider(
                              height: 5,
                            ),
                            Text(
                              widget.listing.data['UserName']
                                  .toString()
                                  .toUpperCase(),
                              style: Fonts.T1,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      VerticalDivider(
                        width: 20,
                      ),
                      IconButton(
                        padding: EdgeInsets.all(10),
                        icon: Icon(Icons.chat),
                        color: Colors.blue,
                        iconSize: 35,
                        onPressed: () {},
                      ),
                      IconButton(
                        padding: EdgeInsets.fromLTRB(10, 10, 15, 10),
                        icon: Icon(Icons.call),
                        color: Colors.pink,
                        iconSize: 35,
                        onPressed: () {},
                      )
                    ],
                  ),
                ],
              ),
            )),
      )
    ]));
  }

  static SliverList TempMap() {
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
                child: Center(
                  child: Text(
                    "MAP VIEW",
                    style: Fonts.S2,
                  ),
                )),
          ),
        )
      ]),
    );
  }

  SliverList MapRegion(BuildContext context) {
    double lat = widget.listing.data["Lat"];
    double lon = widget.listing.data["Lon"];
    double zoom = widget.listing.data["Zoom"];

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
                            target: LatLng(lat, lon), zoom: zoom),
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
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: 40,
                                          child: Text(
                                            widget.listing.data["Title"],
                                            //"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the",
                                            maxLines: 3,
                                            softWrap: true,
                                            style: Fonts.T1,
                                          ),
                                          alignment: Alignment(-1, 0),
                                        ),
                                        Container(
                                          height: 21,
                                          child: GetListingDateDetail(
                                              widget.listing.data),
                                          alignment: Alignment(-1, 0),
                                        )
                                      ],
                                    ),
                                  ),
                                  //VerticalDivider(),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          widget.listing.data["Renumeration"] +
                                              " " +
                                              widget.listing.data["Currency"],
                                          style: Fonts.N1,
                                        ),
                                        Divider(
                                          height: 4,
                                        ),
                                        Text(
                                          "PER TASK",
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
                                          PostingDateProcessor(widget
                                              .listing.data["PostingDate"]),
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
                            onPressed: () {},
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

  GetListingDateDetail(data) {
    var fromdate = data["FromDate"];
    var toDate = data["ToDate"];
    var fromDateType = data["FromDateType"];
    var toDateType = data["ToDateType"];
    if (fromDateType.toString().toUpperCase() == "ON") {
      return Text(
        "ON " + fromdate,
        //"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the",
        maxLines: 3,
        softWrap: true,
        style: Fonts.S3,
      );
    }

    if (fromDateType.toString().toUpperCase() == "BEFORE") {
      return Text(
        "BEFORE " + fromdate,
        //"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the",
        maxLines: 3,
        softWrap: true,
        style: Fonts.S3,
      );
    }

    if (fromDateType.toString().toUpperCase() == "FROM") {
      if (toDateType.toString().toUpperCase() == "FOREVER") {
        return Text(
          "FROM " + fromdate + " FOR EVER (AND EVER)",
          //"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the",
          maxLines: 3,
          softWrap: true,
          style: Fonts.S3,
        );
      } else {
        return Text(
          "FROM " + fromdate + " TO " + toDate,
          //"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the",
          maxLines: 3,
          softWrap: true,
          style: Fonts.S3,
        );
      }
    }
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
