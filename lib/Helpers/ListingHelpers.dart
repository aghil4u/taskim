import 'package:flutter/material.dart';
import 'package:task.im/Style/Style.dart' as Style;

Container ListingTile_Square(String title, String description, String location,
        String price, Color color) =>
    Container(
      child: Padding(
        padding: EdgeInsets.all(2.0),
        child: Card(
            elevation: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4)),
                        child: Container(
                            color: color,
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    price,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontFamily: Style.Fonts.quickBoldFont,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      height: 130,
                      color: Colors.transparent,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: Style.Fonts.quickBoldFont,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );

Container ListingTile_Regular(String title, String description, String location,
    String price, Color color, List<dynamic> photos, int index) {
  return Container(
    height: 150,
    child: Hero(
      tag: "ListingTag" + index.toString(),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 3.0,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: constraints.maxWidth - constraints.maxHeight,
                    height: constraints.maxHeight,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: Style.Fonts.quickBoldFont,
                                fontWeight: FontWeight.w600),
                          ),
                          Divider(
                            height: 8,
                          ),
                          Text(
                            description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: Style.Fonts.quickNormalFont,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    // color: Colors.blue,
                    width: constraints.maxHeight,

                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                        child: imageCell(photos, price)),
                  )
                ],
              );
            },
          )),
    ),
  );
}

imageCell(List<dynamic> photos, String price) {
  if (photos == null || photos.length < 1) {
    return Container(
        color: Colors.blueAccent,
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Stack(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      price,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Style.Fonts.N2,
                    ),
                  ],
                ),
              ],
            )));
  } else {
    return Container(
        color: Colors.blueAccent,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            FadeInImage.assetNetwork(
              image: photos.first.toString(),
              fit: BoxFit.fill,
              placeholder: "",
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    price,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Style.Fonts.N2,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

String PostingDateProcessor(data) {
  var date = DateTime.parse(data).toLocal();
  String text = "POSTED ON " + Style.Format.StandardDateFormat.format(date);
  Duration difference = DateTime.now().difference(date);
  print(difference);
  if (difference.inDays < 1) {
    if (difference.inHours < 1) {
      return "POSTED " + difference.inMinutes.toString() + " MINUTES BEFORE";
    } else {
      return "POSTED " + difference.inHours.toString() + " HOURS BEFORE";
    }
  }
  if (difference.inDays < 7) {
    return "POSTED " + difference.inDays.toString() + " DAYS BEFORE";
  }

  return text;
}
