import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/Listing.dart';

class StarredListings extends ChangeNotifier {
  final List<Listing> _starredListings = [];

  List<Listing> get starredListings => _starredListings;

  void toggleStar(Listing listing) async {
    if (_starredListings.contains(listing)) {
      _starredListings.remove(listing);

      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String uid = user.uid;

        try {
          await FirebaseFirestore.instance.collection('users').doc(uid).update({
            'favouriteListings': FieldValue.arrayRemove([listing.id])
          });
          print('Listing removed from favourites.');
        } catch (e) {
          print('Error removing from favourites: $e');
        }
      }

    } else {
      _starredListings.add(listing);

      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String uid = user.uid;

        try {
          await FirebaseFirestore.instance.collection('users').doc(uid).update({
            'favouriteListings': FieldValue.arrayUnion([listing.id])
          });
          print('Listing added to favourites.');
        } catch (e) {
          print('Error adding to favourites: $e');
        }
      }
    }
  }

  Future<List<Listing>> getListings() async {
    List<Listing> userStarredListings = [];
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("Hello!");
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (doc.exists && doc.data() != null) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        List<dynamic> favouriteListings = data['favouriteListings'];
        for (String listingId in favouriteListings) {
          DocumentSnapshot listingDoc = await FirebaseFirestore.instance.collection('houses').doc(listingId).get();
          if (listingDoc.exists) {
            Listing listing = Listing.fromMap(listingDoc.data() as Map<String, dynamic>, reference: listingDoc.reference);
            userStarredListings.add(listing);
            print(listing.address);
            print("Address ^");
          }
        }
      }
    }
    print(userStarredListings);
    print("Printed");
    return userStarredListings;
  }
}