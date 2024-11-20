import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'AddListingPage.dart';
import 'AppDrawer.dart';
import 'Listing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'ListingsModel.dart';
import 'AppDrawer.dart';
import 'Listing.dart';
import 'AddListing.dart';

class ListingsPage extends StatefulWidget {
  const ListingsPage({super.key});

  @override
  ListingsPageState createState() => ListingsPageState();
}

class ListingsPageState extends State<ListingsPage> {
  final TextEditingController _SearchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Listing> listings = [];
  List<Listing> filteredListings = [];

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
  void initState() {
    super.initState();
    _fetchListings();
  }

  Future<void> _fetchListings() async {
    try {
      final QuerySnapshot querySnapshot =
          await _firestore.collection('houses').get();
      setState(() {
        listings = querySnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Listing(
            address: data['address'],
            numBeds: data['numBeds'].toString(),
            numBaths: data['numBaths'].toString(),
            squareFeet: data['squareFeet'].toString(),
            imageURL: data['imageURL'],
            price: data['price'].toDouble(),
            moreInfo: data['moreInfo'],
            showMore: true,
          );
        }).toList();
        filteredListings = listings;
        _showSnackbar("Listings successfully loaded!");
      });
    } catch (e) {
      _showSnackbar("Error fetching listings: $e");
    }
  }

  Future<void> _saveSearch(String searchQuery) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> searches = prefs.getStringList('searchHistory') ?? [];
    searches.add(searchQuery);
    await prefs.setStringList('searchHistory', searches);
  }

  void _handleSearch(String searchQuery) {
    setState(() {
      filteredListings = listings
          .where((listing) =>
              listing.address.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    });
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }


  void _openAddListingPage() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddListingPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        title: const Text("Realty"),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              children: [
                const SizedBox(width: 55),
                Expanded(
                  child: TextField(
                    controller: _SearchController,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        _handleSearch(value);
                      } else {
                        setState(() {filteredListings = listings;});
                      }
                    },
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        _showSnackbar("Search results updated for: $value");
                        _saveSearch(value);
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      labelText: 'Search Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      fillColor: Colors.grey.shade300,
                      filled: true,

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
                  ),
                ),
                SizedBox(
                  width: 55,
                  child: IconButton(
                      onPressed: () => setState(() async {
                        _openAddListingPage();
                      }),
                      icon: const Icon(Icons.add)
                  ),
              ),
              SizedBox(
                width: 55,
                child: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: addListing,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredListings.length,
              itemBuilder: (context, index) {
                return ListingWidget(listing: filteredListings[index]);
              },
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