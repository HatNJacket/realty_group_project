import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'ListingsModel.dart';
import 'AppDrawer.dart';
import 'Listing.dart';
import 'AddListing.dart';

// ignore_for_file: file_names
class ListingsPage extends StatefulWidget {
  const ListingsPage({super.key});

  @override
  ListingsPageState createState() => ListingsPageState();
}

class ListingsPageState extends State<ListingsPage> {

  ListingsModel listingsModel = ListingsModel();

  // ignore: non_constant_identifier_names
  final TextEditingController _SearchController = TextEditingController();

  void addListing() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddListing(),
      ),
    );
  }

  String numToCurrency(double num) {
    final formatter = NumberFormat.currency(locale: 'en_US', decimalDigits: 2, symbol: '\$');
    return formatter.format(num);
  }

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
      title: const Text("Realty"),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            children: [
              const SizedBox(width: 55),
              Expanded(
                child: TextField(
                  controller: _SearchController,
                  onSubmitted: (_) => setState(() {}),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    labelText: 'Search Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    fillColor: Colors.grey.shade300,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(
                width: 55,
                child: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: addListing,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: listingsModel.getListings(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                List<QueryDocumentSnapshot> filteredDocs = snapshot.data!.docs.where((doc) {
                  String address = doc['address'].toString().toLowerCase();
                  return _SearchController.text.isEmpty || address.contains(_SearchController.text.toLowerCase());
                }).toList();

                return ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: filteredDocs.map((DocumentSnapshot document) =>
                      _buildListing(context, document)).toList() ?? [],
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildListing(BuildContext context, DocumentSnapshot listingData) {
    final listing = Listing.fromMap(listingData.data() as Map<String, dynamic>, reference: listingData.reference);
    return ListingWidget(listing: listing);
  }
}