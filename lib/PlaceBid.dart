import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Listing.dart';
import 'ListingsModel.dart';

// ignore_for_file: file_names
class PlaceBid extends StatefulWidget {

  final Listing listing;

  const PlaceBid({super.key, required this.listing});

  @override
  PlaceBidState createState() => PlaceBidState();
}

class PlaceBidState extends State<PlaceBid> {

  ListingsModel listingsModel = ListingsModel();

  @override
  void initState() {
    super.initState();
    widget.listing.highestBid = widget.listing.highestBid ?? widget.listing.price;
  }

  // ignore: non_constant_identifier_names
  final TextEditingController _BidController = TextEditingController();

  String numToCurrency(double num) {
    final formatter = NumberFormat.currency(locale: 'en_US', decimalDigits: 2, symbol: '\$');
    return formatter.format(num);
  }

    void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void onPlacedBid() async {
    if (_BidController.text.isEmpty){
      _showSnackbar("Please enter a valid bid amount.");
      return;
    }
    double newBid = double.parse(_BidController.text);

    if (newBid > widget.listing.highestBid!) {
      DocumentSnapshot snapshot = await widget.listing.reference!.get();
      _showSnackbar("Bid of \$${_BidController.text} successfully created.");
      
      setState(() {
        listingsModel.updateListingBid(snapshot, newBid);
        _BidController.clear();
        widget.listing.showMore = true;
      });

      Navigator.pop(context);
    }
  }

  String? get errorMessage {

    if (_BidController.text.isNotEmpty) {
      print(_BidController);
      double newBid = double.parse(_BidController.text);

      if (newBid > widget.listing.highestBid!) {
        return null;
      }

      return "Must be higher";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        title: const Text("Realty")
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        ListingWidget(listing: widget.listing),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Current Highest Bid: ', style: TextStyle(fontSize: 17)
            ),
            Text(
              widget.listing.highestBid != null ?
              numToCurrency(widget.listing.highestBid!) :
              numToCurrency(widget.listing.price!),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)
            )
          ],
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                'Place Bid: ', style: TextStyle(fontSize: 17)
            ),
            SizedBox(
              width: 170,
              child: TextField(
                controller: _BidController,
                decoration: InputDecoration(
                  labelText: 'e.g. ${numToCurrency(widget.listing.highestBid! * 1.05)}',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  fillColor: Colors.grey.shade300,
                  filled: true,
                  errorText: errorMessage,
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
          ],
        ),
        const SizedBox(height: 50),
        TextButton(
            onPressed: onPlacedBid,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.grey.shade300),
              foregroundColor: WidgetStateProperty.all(Colors.grey.shade700),
            ),
            child: const Text("Place Bid"))
      ],
    );
  }
}