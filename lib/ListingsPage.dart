import 'package:flutter/material.dart';
import 'AppDrawer.dart';
import 'Listing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            price: data['price'],
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
    _saveSearch(searchQuery);
    setState(() {
      filteredListings = listings
          .where((listing) =>
              listing.address.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    });
    _showSnackbar("Search results updated for: $searchQuery");
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
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
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        _handleSearch(value);
                      } else {
                        setState(() {filteredListings = listings;});
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
                    ),
                  ),
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
    );
  }
}