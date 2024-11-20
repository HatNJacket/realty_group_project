import 'package:flutter/material.dart';

class AddListing extends StatelessWidget {
  AddListing({super.key});

  final TextEditingController _PriceController = TextEditingController();
  final TextEditingController _AddressController = TextEditingController();
  final TextEditingController _BedsController = TextEditingController();
  final TextEditingController _BathsController = TextEditingController();
  final TextEditingController _SquareFeetController = TextEditingController();
  final TextEditingController _AgentController = TextEditingController();

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
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              "Create a New Listing", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
        ),
        const SizedBox(height: 40),
        Row(
          children: [
            const Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Asking Price: ",
                    style: TextStyle(fontSize: 17),
                  ),
                  Text(
                    "Address: ",
                    style: TextStyle(fontSize: 17),
                  ),
                  Text(
                    "# of Beds: ",
                    style: TextStyle(fontSize: 17),
                  ),
                  Text(
                    "# of Baths: ",
                    style: TextStyle(fontSize: 17),
                  ),
                  Text(
                    "Square Feet: ",
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                    controller: _PriceController,
                    decoration: InputDecoration(
                      labelText: 'e.g. 825,000',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      fillColor: Colors.grey.shade300,
                      filled: true,
                    ),
                  ),
                  TextField(
                    controller: _AddressController,
                    decoration: InputDecoration(
                      labelText: 'e.g. 2000 Simcoe Street, Oshawa Ontario',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      fillColor: Colors.grey.shade300,
                      filled: true,
                    ),
                  ),
                  TextField(
                    controller: _BedsController,
                    decoration: InputDecoration(
                      labelText: 'e.g. 3',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      fillColor: Colors.grey.shade300,
                      filled: true,
                    ),
                  ),
                  TextField(
                    controller: _BathsController,
                    decoration: InputDecoration(
                      labelText: 'e.g. 2.5',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      fillColor: Colors.grey.shade300,
                      filled: true,
                    ),
                  ),
                  TextField(
                    controller: _SquareFeetController,
                    decoration: InputDecoration(
                      labelText: 'e.g. 1,500',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      fillColor: Colors.grey.shade300,
                      filled: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}