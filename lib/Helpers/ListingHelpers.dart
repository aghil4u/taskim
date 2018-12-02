import 'package:flutter/material.dart';
import 'package:task.im/Style/theme.dart' as Theme;

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
                                        fontFamily: Theme.Fonts.quickBoldFont,
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
                            fontFamily: Theme.Fonts.quickBoldFont,
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
    String price, Color color) {
  return Container(
    height: 100,
    child: Card(child: LayoutBuilder(
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
                          fontFamily: Theme.Fonts.quickBoldFont,
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
                        fontFamily: Theme.Fonts.quickNormalFont,
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
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4)),
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
                                fontFamily: Theme.Fonts.quickBoldFont,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    )),
              ),
            )
          ],
        );
      },
    )),
  );
}
