import 'package:flutter/material.dart';
import 'package:task.im/services/ListingManager.dart';

class ExploreListings extends StatefulWidget {
  @override
  _ListingsContainerState createState() => _ListingsContainerState();
}

class _ListingsContainerState extends State<ExploreListings> {
  var manager = ListingManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Listings(),
    );
  }

  Listings() {
    return FutureBuilder(
      future: manager.getListing(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: 2,
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(snapshot.data.documents[index].data["Title"]),
              );
            },
          );
        }
      },
    );
  }
}
