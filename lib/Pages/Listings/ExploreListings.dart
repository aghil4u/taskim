import 'package:flutter/material.dart';
import 'package:task.im/services/ListingManager.dart';
import 'package:task.im/Helpers/ListingHelpers.dart';

class ExploreListings extends StatefulWidget {
  @override
  _ListingsContainerState createState() => _ListingsContainerState();
}

class _ListingsContainerState extends State<ExploreListings> {
  var manager = ListingManager();
  List items = new List();
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;

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
      future: manager.FetchDocuments(),
      builder: (context, snapshot) {
        return ListView.builder(
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          itemCount: items.length + 1,
          itemBuilder: (_, index) {
            if (index == items.length) {
              return _buildProgressIndicator();
            } else {
              return ListTile(
                title: ListingTile_Regular(
                    items[index].data["Title"],
                    items[index].data["Description"],
                    "location",
                    items[index].data["Renumeration"],
                    Colors.blue,
                    index),
              );
            }
          },
        );
      },
    );
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
}
