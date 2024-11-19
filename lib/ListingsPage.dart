import 'package:flutter/material.dart';
import 'AppDrawer.dart';
import 'Listing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListingsPage extends StatefulWidget {
  const ListingsPage({super.key});

  @override
  ListingsPageState createState() => ListingsPageState();
}

class ListingsPageState extends State<ListingsPage> {
  final TextEditingController _SearchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Listing> listings = [];

  @override
  void initState() {
    super.initState();
    _fetchListings();
  }

  Future<void> _fetchListings() async {
    try {
      final QuerySnapshot querySnapshot =
          await _firestore.collection('listings').get();
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
      });
    } catch (e) {
      print('Error fetching listings: $e');
    }
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
                      print("Searching: $value");
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
              itemCount: listings.length,
              itemBuilder: (context, index) {
                return ListingWidget(listing: listings[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
