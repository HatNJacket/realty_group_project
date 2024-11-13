
import 'package:flutter/material.dart';
import 'AppDrawer.dart';
import 'Listing.dart';

// ignore_for_file: file_names
class ListingsPage extends StatefulWidget {
  const ListingsPage({super.key});

  @override
  ListingsPageState createState() => ListingsPageState();
}

class ListingsPageState extends State<ListingsPage> {

  // ignore: non_constant_identifier_names
  final TextEditingController _SearchController = TextEditingController();

  //TODO: Replace temporary listings list with SQL or web database
  final List<Listing> listings = [
    Listing(title: 'House 1',
    description: 'It an house',
    imageURL: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwNUhxbHpwCgZLNYYRF4JMfbhKQ-VQVMQRUA&s',
    price: 100000.01,
    moreInfo: 'Small house',
    ),
    Listing(title: 'House 2',
    description: 'It an different house',
    imageURL: 'https://i.ytimg.com/vi/_L6jEtMK8No/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLD3Jf8E6GHx6CjfSmFk80hileTi_A',
    price: 199999.99,
    moreInfo: 'Bigger house',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: AppDrawer(),
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
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            children: [
              const SizedBox(width: 55),
              Expanded(
                child: TextField(
                  controller: _SearchController,
                  onSubmitted: (String value) => print(value),
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
                  onPressed: () => print("Added Listing"),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: listings.length,
            itemBuilder: (context, index){
              return ListingWidget(listing: listings[index]);
            }
            )
        ),
      ],
    );
  }
}