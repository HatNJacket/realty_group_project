import 'Listing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListingsModel{

  Stream<QuerySnapshot> getListings() {
    return FirebaseFirestore.instance.collection('houses')
        .snapshots();
  }

  Future<void> addListing(Listing listing) async {
    try {
      await FirebaseFirestore.instance.collection('houses').add({
        'address': listing.address,
        'numBeds': listing.numBeds,
        'numBaths': listing.numBaths,
        'squareFeet': listing.squareFeet,
        'imageURL': listing.imageURL,
        'price': listing.price,
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

  Future<void> updateListingPrice(DocumentSnapshot document, double newPrice) async {
    document.reference.update({
      "price": newPrice
    });
  }
}