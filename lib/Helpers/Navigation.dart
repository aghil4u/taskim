import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:task.im/Pages/Listings/CreateListing.dart';
import 'package:task.im/Pages/Listings/ExploreListings.dart';

class Navigation {
  static Router router;

  static void initPaths() {
    router = new Router();
    router.define('/CreteLisitng', handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return CreateListingPage();
    }));
    router.define('/explore', handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return ExploreListings();
    }));
  }
}
