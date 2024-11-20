import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddListingPage extends StatefulWidget {
  const AddListingPage({super.key});

  @override
  AddListingPageState createState() => AddListingPageState();
}

class AddListingPageState extends State<AddListingPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _numBedsController = TextEditingController();
  final TextEditingController _numBathsController = TextEditingController();
  final TextEditingController _squareFeetController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _addListing() async {
    if (_addressController.text.isEmpty ||
        _numBedsController.text.isEmpty ||
        _numBathsController.text.isEmpty ||
        _squareFeetController.text.isEmpty ||
        _priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields must be filled!")),
      );
      return;
    }

    try {
      await _firestore.collection('houses').add({
        'address': _addressController.text,
        'numBeds': int.parse(_numBedsController.text),
        'numBaths': int.parse(_numBathsController.text),
        'squareFeet': int.parse(_squareFeetController.text),
        'price': double.parse(_priceController.text),
        'imageURL': 'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyaminmellish-186077.jpg&fm=jpg', // Placeholder for image URL
        'moreInfo': '', // Placeholder for additional info
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Listing added successfully!")),
      );

      _clearFields();

      Navigator.pop(context);

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add listing: $e")),
      );
    }
  }

  void _clearFields() {
    _addressController.clear();
    _numBedsController.clear();
    _numBathsController.clear();
    _squareFeetController.clear();
    _priceController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        title: const Text("Add Listing"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField(_addressController, "Address", TextInputType.text),
            const SizedBox(height: 16),
            _buildTextField(
                _numBedsController, "Number of Bedrooms", TextInputType.number),
            const SizedBox(height: 16),
            _buildTextField(
                _numBathsController, "Number of Bathrooms", TextInputType.number),
            const SizedBox(height: 16),
            _buildTextField(
                _squareFeetController, "Square Feet", TextInputType.number),
            const SizedBox(height: 16),
            _buildTextField(
                _priceController, "Price", TextInputType.number),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _addListing,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text("Add Listing"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, TextInputType inputType) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}