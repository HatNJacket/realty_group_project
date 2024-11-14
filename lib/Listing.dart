import 'package:flutter/material.dart';

class Listing {
  final String title;
  final String description;
  final String imageURL;
  final double price;
  final String moreInfo;

  Listing({
    required this.title,
    required this.description,
    required this.imageURL,
    required this.price,
    required this.moreInfo,
  });
}

class ListingWidget extends StatefulWidget{
  final Listing listing;

  ListingWidget({required this.listing});

  @override
  _ListingWidgetState createState() => _ListingWidgetState();
}

class _ListingWidgetState extends State<ListingWidget>{
  bool _tapped = false;

  void _toggleMoreInfo() {
    setState((){
      _tapped = !_tapped;
    });
  }

  @override
  Widget build(BuildContext context){
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(widget.listing.imageURL),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.listing.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.listing.description,
              style: TextStyle(fontSize: 16),
            ), 
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '\$${widget.listing.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ) 
          ),
          if(_tapped)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:Text(
              widget.listing.moreInfo,
              style: TextStyle(fontSize: 16),
            ),
          ),
          TextButton(onPressed: _toggleMoreInfo,
          child: Text(_tapped ? 'Show Less' : 'Show More')),
        ],
      )
    );
  }
}