import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:task.im/Pages/Listings/CreateListing.dart';
import 'package:task.im/Pages/Listings/ExploreListings.dart';
import 'package:task.im/Pages/Listings/ListingDetailsPage.dart';

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

    router.define('/listingDetails', handler: Handler(
        handlerFunc: (BuildContext context, Map<String, List<dynamic>> params) {
      return ListingDetailsPage(
          listing: params["listing"]?.first,
          index: int.parse(params["index"]?.first));
    }));
  }
}
