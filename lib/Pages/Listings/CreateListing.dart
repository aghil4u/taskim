import 'package:flutter/material.dart';

class CreateListing extends StatefulWidget {
  _CreateListingState createState() => _CreateListingState();
}

class _CreateListingState extends State<CreateListing> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Hero(
        child: Container(
          color: Colors.pink,
        ),
        tag: "FabTag",
      ),
    );
  }
}
