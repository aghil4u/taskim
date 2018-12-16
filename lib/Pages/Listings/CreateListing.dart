import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task.im/Style/Style.dart' as iTheme;
import 'package:task.im/services/ListingManager.dart';
import 'dart:math' as math;
import 'package:geocoder/geocoder.dart';

class CreateListingPage extends StatefulWidget {
  const CreateListingPage({
    Key key,
  }) : super(key: key);
  _CreateListingPageState createState() => _CreateListingPageState();
}

class _CreateListingPageState extends State<CreateListingPage>
    with AutomaticKeepAliveClientMixin {
//-----------------------------------
  TextEditingController _titleFieldController;
  String _listingTitle = "";
  TextEditingController _renumerationFieldController;
  String _listingRenumeration = "";
  TextEditingController _descriptionFieldController;
  String _listingDescription = "";
  String _fromdate =
      iTheme.Format.StandardDateFormat.format(DateTime.now()).toString();
  String _todate = iTheme.Format.StandardDateFormat
      .format(DateTime.now().add(Duration(days: 5)))
      .toString();
  String _dateType = "before";
  String _dateType2 = "to";
  String _currency = "USD";
  String _locationType = "NEAR";
  List<String> _listingPhotos = [];

  bool date2Visibility = false;
  bool chooseLocationVisibility = true;
  String _location = "CHOOSE LOCATION";
  double _lat;
  double _lon;
  double _zoom;
  GoogleMapController gmc;
//------------------------------------

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
            fontFamily: iTheme.Fonts.quickBoldFont),
      ),
      //backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

  void initState() {
    super.initState();
    _titleFieldController = new TextEditingController();
    _titleFieldController.text = _listingTitle;
    _renumerationFieldController = new TextEditingController();
    _renumerationFieldController.text = _listingRenumeration;
    _descriptionFieldController = new TextEditingController();
    _descriptionFieldController.text = _listingDescription;
    _scaffoldKey = GlobalKey();
  }

  Size deviceSize;
  ListingManager manager = ListingManager();

  final PageController _pvc = PageController(initialPage: 0);
  ScrollController _scrollController = new ScrollController();
  var _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;

    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: true,
        body: Theme(
          data: Theme.of(context).copyWith(
              highlightColor: Colors.white,
              inputDecorationTheme: InputDecorationTheme(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)))),
          child: Container(
              color: Colors.grey[900],
              child: PageView(
                physics: BouncingScrollPhysics(),
                controller: _pvc,
                children: <Widget>[
                  TitlePage(),
                  RenumerationPage(),
                  DescriptionPage(),
                  PhotosPage(parent: this),
                  LocationPage(),
                  PreviewPage()
                ],
              )),
        ));
  }

  TextStyle _dts() {
    return TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white);
  }

  Widget TitlePage() {
    return Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                iTheme.Pigments.Gradient1Start,
                iTheme.Pigments.Gradient1End
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Center(
              child: Wrap(
            children: <Widget>[
              Text(
                "I WANT SOMEONE TO ",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 40.0,
                    color: Colors.white),
              ),
              Container(
                child: TextField(
                  controller: _titleFieldController,
                  textInputAction: TextInputAction.done,
                  maxLength: 150,
                  autocorrect: true,
                  maxLines: 1,
                  cursorColor: Colors.white,
                  textCapitalization: TextCapitalization.characters,
                  style: _dts(),
                  onSubmitted: (value) {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  onEditingComplete: () {
                    _listingTitle = _titleFieldController.text;
                  },
                ),
              ),
              Row(
                children: <Widget>[
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: _dateType,
                      iconSize: 30,
                      items: [
                        DropdownMenuItem(
                          value: "from",
                          child: Text(
                            "FROM",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.grey[400]),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "on",
                          child: Text(
                            "ON",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.grey[400]),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "before",
                          child: Text(
                            "BEFORE",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.grey[400]),
                          ),
                        )
                      ],
                      onChanged: (String i) {
                        setState(() {
                          _dateType = i;
                          if (i == "from") {
                            date2Visibility = true;
                          } else {
                            date2Visibility = false;
                          }
                        });
                      },
                      style: _dts(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: GestureDetector(
                      child: Text(
                        _fromdate,
                        style: _dts(),
                      ),
                      onTap: () {
                        _selectDate(_fromdate);
                      },
                    ),
                  )
                ],
              ),
              Opacity(
                opacity: date2Visibility ? 1 : 0,
                child: Row(
                  children: <Widget>[
                    DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _dateType2,
                        iconSize: 30,
                        items: [
                          DropdownMenuItem(
                            value: "to",
                            child: Text(
                              "TO",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.grey[400]),
                            ),
                          ),
                          DropdownMenuItem(
                            value: "forever",
                            child: Text(
                              "FOR EVER",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.grey[400]),
                            ),
                          ),
                        ],
                        onChanged: (String i) {
                          setState(() {
                            _dateType2 = i;
                            if (i == "forever") {
                              _todate = "(A LONG TIME)";
                            } else {
                              _todate = iTheme.Format.StandardDateFormat.format(
                                  DateTime.now().add(Duration(days: 5)));
                            }
                          });
                        },
                        style: _dts(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: GestureDetector(
                        child: Text(
                          _todate,
                          style: _dts(),
                        ),
                        onTap: () {
                          _selectDate(_todate);
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
        ));
  }

  Future _selectDate(var datetoset) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime.now(),
      lastDate: new DateTime(2020),
    );

    if (picked != null)
      setState(() => datetoset =
          iTheme.Format.StandardDateFormat.format(picked).toString());
  }

  Widget RenumerationPage() {
    return Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                iTheme.Pigments.Gradient2Start,
                iTheme.Pigments.Gradient2End
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Center(
              child: Wrap(
            children: <Widget>[
              Text(
                "I'M WILLING TO SPEND",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 40.0,
                    color: Colors.white),
              ),
              Row(
                children: <Widget>[
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: _currency,
                      iconSize: 30,
                      items: [
                        DropdownMenuItem(
                          value: "USD",
                          child: Text(
                            "USD",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.grey[400]),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "AED",
                          child: Text(
                            "AED",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.grey[400]),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "INR",
                          child: Text(
                            "INR",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.grey[400]),
                          ),
                        )
                      ],
                      onChanged: (String i) {
                        setState(() {
                          _currency = i;
                          // if (i == "from") {
                          //   date2Visibility = true;
                          // } else {
                          //   date2Visibility = false;
                          // }
                        });
                      },
                      style: _dts(),
                    ),
                  ),
                  Container(
                    width: 70,
                    child: TextField(
                        onSubmitted: (value) {
                          FocusScope.of(context).requestFocus(new FocusNode());
                        },
                        controller: _renumerationFieldController,
                        textAlign: TextAlign.center,
                        autocorrect: true,
                        maxLines: 1,
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.numberWithOptions(),
                        onEditingComplete: () {
                          _listingRenumeration =
                              _renumerationFieldController.text;
                        },
                        style: _dts()),
                  ),
                  Text(
                    "FOR THIS TASK",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20.0,
                        color: Colors.white),
                  ),
                ],
              ),
            ],
          )),
        ));
  }

  Widget DescriptionPage() {
    return Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                iTheme.Pigments.Gradient3Start,
                iTheme.Pigments.Gradient3End
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Center(
              child: Wrap(
            children: <Widget>[
              Text(
                "MORE ABOUT MY REQUIREMENT ",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 40.0,
                    color: Colors.white),
              ),
              Container(
                child: TextField(
                    onSubmitted: (value) {
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    controller: _descriptionFieldController,
                    textAlign: TextAlign.left,
                    autocorrect: false,
                    maxLines: 10,
                    cursorColor: Colors.white,
                    onEditingComplete: () {
                      _listingDescription = _descriptionFieldController.text;
                    },
                    style: _dts()),
              ),
            ],
          )),
        ));
  }

  Widget LocationPage() {
    return Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                iTheme.Pigments.Gradient2Start,
                iTheme.Pigments.Gradient2End
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Center(
              child: Wrap(
            children: <Widget>[
              Text(
                "TASK IS LOCATED",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 40.0,
                    color: Colors.white),
              ),
              Row(
                children: <Widget>[
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: _locationType,
                      iconSize: 30,
                      items: [
                        DropdownMenuItem(
                          value: "NEAR",
                          child: Text(
                            "NEAR",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.grey[400]),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "AT",
                          child: Text(
                            "AT",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.grey[400]),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "AROUND",
                          child: Text(
                            "AROUND",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.grey[400]),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "ANYWHERE",
                          child: Text(
                            "ANYWHERE",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.grey[400]),
                          ),
                        )
                      ],
                      onChanged: (String i) {
                        setState(() {
                          _locationType = i;
                          if (i != "ANYWHERE") {
                            chooseLocationVisibility = true;
                          } else {
                            chooseLocationVisibility = false;
                          }
                        });
                      },
                      style: _dts(),
                    ),
                  ),
                  Opacity(
                    opacity: chooseLocationVisibility ? 1 : 0,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: GestureDetector(
                        child: Text(
                          _location,
                          overflow: TextOverflow.fade,
                          style: _dts(),
                        ),
                        onTap: () {
                          _selectLocation(_location);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ],
          )),
        ));
  }

  Widget PreviewPage() {
    return Container(
      color: Colors.amber,
      child: Center(
          child: Container(
        margin: EdgeInsets.only(top: 170.0),
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: iTheme.Pigments.loginGradientEnd,
                offset: Offset(0.0, 10.0),
                blurRadius: 20.0,
              ),
            ],
            color: iTheme.Pigments.loginGradientEnd),
        child: MaterialButton(
            highlightColor: Colors.transparent,
            splashColor: iTheme.Pigments.loginGradientEnd,
            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
              child: Text(
                "POST LISTING",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: "WorkSansBold"),
              ),
            ),
            onPressed: () {
              manager.AddListing({
                'PostingDate': DateTime.now().toUtc().toIso8601String(),
                'TimeStamp': DateTime.now().toUtc().year.toString() +
                    DateTime.now().toUtc().month.toString() +
                    DateTime.now().toUtc().day.toString() +
                    DateTime.now().toUtc().hour.toString() +
                    DateTime.now().toUtc().minute.toString() +
                    DateTime.now().toUtc().second.toString() +
                    math.Random().nextInt(1000).toString(),
                'UserName': manager.CurrentUser.displayName,
                'UID': manager.CurrentUser.uid,
                'LocationType': _locationType,
                'Lat': _lat,
                'Lon': _lon,
                'Address': _location,
                'Zoom': _zoom,
                'Renumeration': _renumerationFieldController.text,
                'Currency': _currency,
                'Title': _titleFieldController.text,
                'Description': _descriptionFieldController.text,
                'FromDate': _fromdate,
                'ToDate': _todate,
                'FromDateType': _dateType,
                'ToDateType': _dateType2,
                'Photos': _listingPhotos
              }).then((result) {
                if (result == true) {
                  showInSnackBar("Yay! Your Listing is now Live.");
                } else {
                  showInSnackBar("Oops! Failed to post your listing.");
                }
              }).catchError((e) {
                print(e);
              });
            }),
      )),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Future _selectLocation(String location) async {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Choose Location"),
              contentPadding: EdgeInsets.all(0),
              titlePadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              content: Container(
                  height: 500,
                  width: 350,
                  child: Stack(
                    children: <Widget>[
                      GoogleMap(
                        onMapCreated: _onMapCreated,
                        options: GoogleMapOptions(
                            myLocationEnabled: true,
                            compassEnabled: false,
                            tiltGesturesEnabled: false,
                            trackCameraPosition: true,
                            cameraPosition: CameraPosition(
                                target: LatLng(24.454700, 54.377180),
                                zoom: 10.0),
                            scrollGesturesEnabled: true,
                            rotateGesturesEnabled: true),
                      ),
                      Center(
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 25,
                        ),
                      )
                    ],
                  )),
              shape: iTheme.Shapes.DefaultCardShape,
              actions: <Widget>[
                FlatButton(
                  child: Text('CANCEL'),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('ACCEPT'),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  onPressed: () {
                    if (gmc != null) {
                      setState(() {
                        _lat = gmc.cameraPosition.target.latitude;
                        _lon = gmc.cameraPosition.target.longitude;
                        _zoom = gmc.cameraPosition.zoom;

                        _location = _lat.toString() + " " + _lon.toString();
                      });

                      updateLocation(gmc.cameraPosition.target);
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  void _onMapCreated(GoogleMapController controller) {
    gmc = controller;
  }

  Future updateLocation(LatLng target) async {
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        Coordinates(target.latitude, target.longitude));
    var first = addresses.first;
    if (first != null) {
      setState(() {
        _location = first.addressLine;
      });
    }
  }
}

class PhotosPage extends StatefulWidget {
  final _CreateListingPageState parent;
  const PhotosPage({Key key, this.parent}) : super(key: key);
  _PhotosPageState createState() => _PhotosPageState(this.parent);
}

class _PhotosPageState extends State<PhotosPage>
    with AutomaticKeepAliveClientMixin<PhotosPage> {
  List<Widget> _PhotoList;

  _PhotosPageState(_CreateListingPageState parent);

  @override
  void initState() {
    _PhotoList = <Widget>[
      InkWell(
        onTap: () => AddPhotoFromCamera(),
        child: Card(
          margin: EdgeInsets.all(10),
          elevation: 10,
          color: Colors.white70,
          shape: iTheme.Shapes.DefaultCardShape,
          child: InkWell(
            child: Center(
              child: Icon(
                Icons.add_a_photo,
                size: 50,
              ),
            ),
          ),
        ),
      ),
      InkWell(
        onTap: () => AddPhotoFromGallery(),
        child: Card(
          margin: EdgeInsets.all(10),
          elevation: 10,
          color: Colors.white70,
          shape: iTheme.Shapes.DefaultCardShape,
          child: InkWell(
            child: Center(
              child: Icon(
                Icons.add_photo_alternate,
                size: 50,
              ),
            ),
          ),
        ),
      )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                iTheme.Pigments.Gradient4Start,
                iTheme.Pigments.Gradient4End
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: Center(
              child: Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Wrap(
                children: <Widget>[
                  Text(
                    "SOME PHOTOS RELATED TO THE TASK ",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 40.0,
                        color: Colors.white),
                  ),
                ],
              ),
              Expanded(
                  flex: 2,
                  // height: 150 * ((_PhotoList.length - 1) / 3),
                  // padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: _PhotoList.length,
                    addAutomaticKeepAlives: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return _PhotoList[index];
                    },
                  )),
            ],
          )),
        ));
  }

  AddPhotoFromCamera() async {
    var tempImage =
        await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 500);
    if (tempImage != null) {
      uploadImage(tempImage);
    }
  }

  AddPhotoFromGallery() async {
    var tempImage = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 500);
    if (tempImage != null) {
      uploadImage(tempImage);
    }
  }

  uploadImage(File tempImage) {
    var randomno = Random().nextInt(50000);

    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('listingImages/${randomno.toString()}.jpg');
    StorageUploadTask task = firebaseStorageRef.putFile(tempImage);

    task.future.then((value) {
      String address = value.downloadUrl.toString();
      widget.parent.setState(() {
        widget.parent._listingPhotos.add(address);
      });

      setState(() {
        _PhotoList.add(PhotoThumbailCard(address));
        print("ReachedHere");
      });
    }).catchError((e) {
      print(e);
    });
  }

  Widget PhotoThumbailCard(String string) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 10,
      shape: iTheme.Shapes.DefaultCardShape,
      child: InkWell(
          child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child: FadeInImage.assetNetwork(
          placeholder: "",
          image: string,
          fit: BoxFit.cover,
        ),
      )),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
