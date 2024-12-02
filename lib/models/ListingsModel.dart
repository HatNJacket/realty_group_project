import 'Listing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListingsModel{

  Stream<QuerySnapshot> getListings() {
    return FirebaseFirestore.instance.collection('houses').snapshots();
  }

  Future<void> addListing(Listing listing) async {
    try {
      await FirebaseFirestore.instance.collection('houses').add({
        'address': listing.address,
        'numBeds': listing.numBeds,
        'numBaths': listing.numBaths,
        'squareFeet': listing.squareFeet,
        'price': listing.price,
        'highestBid': listing.highestBid,
        'imageURL': listing.imageURL,
        'showMore': listing.showMore,
      });
      print("Listing added successfully!");
    } catch (e) {
      print("Error adding listing: $e");
    }
  }

  Future<void> deleteListing(DocumentSnapshot document) async {
    try {
      document.reference.delete();
      print("Listing deleted successfully!");
    } catch (e) {
      print("Error deleting listing: $e");
    }
  }

  Future<void> updateListingBid(DocumentSnapshot document, double newBid) async {
    document.reference.update({
      "highestBid": newBid
    });
  }
}