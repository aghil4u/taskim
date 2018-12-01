import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ListingManager {
  var data = List();
  var _nomore = false;
  var _isFetching = false;
  DocumentSnapshot _lastDocument;

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

  Future getListing(int length, int i) async {
    return await Firestore.instance.collection('listings').getDocuments();
  }

  Future<List<dynamic>> FetchDocuments() async {
    final QuerySnapshot querySnapshot = await Firestore.instance
        .collection('listings')
        .orderBy('TimeStamp')
        .limit(10)
        .getDocuments()
        .then((onValue) {
      _lastDocument = onValue.documents.last;
      data = onValue.documents;
    });

    return data;
    // your logic here
  }

  Future<List<dynamic>> FetchDocumentsFromLast() async {
    await Firestore.instance
        .collection('listings')
        .orderBy('TimeStamp')
        .startAfter([_lastDocument['TimeStamp']])
        .limit(4)
        .getDocuments()
        .then((onValue) {
          if (onValue.documents.length < 1) {
            _nomore = true;
          }
          _lastDocument = onValue.documents.last;
          for (final DocumentSnapshot snapshot in onValue.documents) {
            data.add(snapshot);
          }
        });

    return data;
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
