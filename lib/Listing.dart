import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'PlaceBid.dart';

// ignore_for_file: file_names
class Listing {
  String? address;
  double? numBeds;
  double? numBaths;
  double? squareFeet;
  String? imageURL;
  double? price;
  double? highestBid;
  bool? showMore;
  DocumentReference? reference;

  Listing({
    required this.address,
    required this.numBeds,
    required this.numBaths,
    required this.squareFeet,
    required this.imageURL,
    required this.price,
    required this.showMore,
    this.reference,
  });

  Listing.fromMap(Map<String, dynamic> map, {this.reference}) {
    address = map["address"];
    numBeds = map["numBeds"].toDouble();
    numBaths = map["numBaths"].toDouble();
    squareFeet = map["squareFeet"].toDouble();
    imageURL = map["imageURL"];
    price = map["price"].toDouble();
    showMore = map["showMore"];
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'numBeds': numBeds,
      'numBaths': numBaths,
      'squareFeet': squareFeet,
      'imageURL': imageURL,
      'price': price,
      'showMore': showMore,
    };
  }
}

class ListingWidget extends StatefulWidget{
  final Listing listing;

  const ListingWidget({super.key, required this.listing});

  @override
  ListingWidgetState createState() => ListingWidgetState();
}

class ListingWidgetState extends State<ListingWidget>{
  bool _tapped = false;

  void _toggleMoreInfo() {
    setState((){
      _tapped = !_tapped;
    });
  }

  void _placeBid() {
    widget.listing.showMore = false;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceBid(listing: widget.listing),
      ),
    );
  }

  void _scheduleViewing() {
    print("Scheduling Viewing");
  }

  String numToCurrency(double num) {
    final formatter = NumberFormat.currency(locale: 'en_US', decimalDigits: 2, symbol: '\$');
    return formatter.format(num);
  }

  @override
  Widget build(BuildContext context){
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Image.network(widget.listing.imageURL!)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                widget.listing.address!,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "${widget.listing.numBeds} beds, ${widget.listing.numBaths} baths, ${widget.listing.squareFeet} sqft, ",
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              numToCurrency(widget.listing.price!),
              style: const TextStyle(fontSize: 18, color: Colors.green),
            )
          ),
          if(_tapped)
          Center(
            child: Column(
              children: [
                SizedBox(
                  width: 200.0,
                  child: TextButton(
                      onPressed: _placeBid,
                      style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.grey.shade300)),
                      child: const Text(
                          "Place Bid",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      )
                  ),
                ),
                SizedBox(
                  width: 200.0,
                  child: TextButton(
                      onPressed: _scheduleViewing,
                      style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.grey.shade300)),
                      child: const Text(
                          "Schedule Viewing",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      )
                  ),
                ),
              ],
            ),
          ),
          if (widget.listing.showMore!)
          Center(
            child: TextButton(
                onPressed: _toggleMoreInfo,
                child: Text(_tapped ? 'Show Less' : 'Show More')
            ),
          ),
        ],
      )
    );
  }
}