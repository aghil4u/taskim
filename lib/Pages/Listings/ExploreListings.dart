import 'package:flutter/material.dart';
import 'package:task.im/services/ListingManager.dart';
import 'package:task.im/Helpers/ListingHelpers.dart';

class ExploreListings extends StatefulWidget {
  @override
  _ListingsContainerState createState() => _ListingsContainerState();
}

class _ListingsContainerState extends State<ExploreListings> {
  var manager = ListingManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text("Explore"),
      ),
      body: Listings(),
    );
  }

  Listings() {
    return FutureBuilder(
      future: manager.getListing(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: RefreshProgressIndicator(),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          List c = snapshot.data.documents;
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: c.length,
            itemBuilder: (_, index) {
              return ListTile(
                title: ListingTile_Regular(
                    c[index].data["Title"],
                    c[index].data["Description"],
                    "location",
                    "500 AED",
                    Colors.blue),
              );
            },
          );
        }
      },
    );
  }
}
