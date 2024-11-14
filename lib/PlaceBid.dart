import 'package:flutter/material.dart';
import 'AppDrawer.dart';
import 'Listing.dart';

// ignore_for_file: file_names
class PlaceBid extends StatefulWidget {

  Widget listing;

  PlaceBid({super.key, required this.listing});

  @override
  PlaceBidState createState() => PlaceBidState();
}

class PlaceBidState extends State<PlaceBid> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: const AppDrawer(),
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
    return widget.listing;
  }
}