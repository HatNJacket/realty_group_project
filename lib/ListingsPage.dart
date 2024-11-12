import 'package:flutter/material.dart';
import 'AppDrawer.dart';

class ListingsPage extends StatefulWidget {
  const ListingsPage({super.key});

  @override
  ListingsPageState createState() => ListingsPageState();
}

class ListingsPageState extends State<ListingsPage> {

  final TextEditingController _SearchController = TextEditingController();

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
        )
      ],
    );
  }
}