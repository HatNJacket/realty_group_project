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
}