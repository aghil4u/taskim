import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task.im/Style/theme.dart' as iTheme;
import 'package:task.im/services/ListingManager.dart';

class CreateListingPage extends StatefulWidget {
  const CreateListingPage({
    Key key,
  }) : super(key: key);
  _CreateListingPageState createState() => _CreateListingPageState();
}

class _CreateListingPageState extends State<CreateListingPage> {
  Size deviceSize;
  var manager = ListingManager();
  var _fromdate =
      iTheme.Format.StandardDateFormat.format(DateTime.now()).toString();
  var _todate = iTheme.Format.StandardDateFormat
      .format(DateTime.now().add(Duration(days: 5)))
      .toString();
  var _dateType = "before";
  var _dateType2 = "to";
  bool date2Visibility = false;
  final PageController _pvc = PageController(initialPage: 0);

  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomPadding: true,
        body: Theme(
          data: Theme.of(context).copyWith(
              highlightColor: Colors.white,
              inputDecorationTheme: InputDecorationTheme(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)))),
          child: Container(
              color: Colors.pink,
              child: PageView(
                physics: BouncingScrollPhysics(),
                controller: _pvc,
                children: <Widget>[
                  TitlePage(),
                  DescriptionPage(),
                  LocationPage(),
                  RenumerationPage(),
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
                iTheme.iColors.loginGradientStart,
                iTheme.iColors.loginGradientEnd
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
                    maxLength: 200,
                    autocorrect: true,
                    maxLines: 1,
                    autofocus: true,
                    cursorColor: Colors.white,
                    textCapitalization: TextCapitalization.characters,
                    style: _dts()),
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
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2019));
    if (picked != null)
      setState(() => datetoset =
          iTheme.Format.StandardDateFormat.format(picked).toString());
  }

  Widget RenumerationPage() {
    return Container(
      color: Colors.amber,
      child: Center(
          child: Text(
        "PAGE1",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      )),
    );
  }

  Widget DescriptionPage() {
    return Container(
      color: Colors.amber,
      child: Center(
          child: Text(
        "PAGE1",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      )),
    );
  }

  Widget LocationPage() {
    return Container(
      color: Colors.amber,
      child: Center(
          child: Text(
        "PAGE1",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      )),
    );
  }

  Widget PreviewPage() {
    return Container(
      color: Colors.amber,
      child: Center(
          child: Text(
        "PAGE1",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      )),
    );
  }
}
