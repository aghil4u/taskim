import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ListingManager {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> AddListing(listing) async {
    if (isLoggedIn()) {
      Firestore.instance.collection('listings').add(listing).catchError((e) {
        return false;
      });
      return true;
    } else {
      print('You need to be logged in');
      return false;
    }
  }

  getData() async {
    return await Firestore.instance.collection('listings').snapshots();
  }

  Future getListing() async {
    return await Firestore.instance.collection('listings').getDocuments();
  }

  updateData(selectedDoc, newValues) {
    Firestore.instance
        .collection('testcrud')
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }

  deleteData(docId) {
    Firestore.instance
        .collection('testcrud')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}
