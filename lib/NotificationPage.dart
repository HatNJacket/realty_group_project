import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'StarredListings.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final starredListings = Provider.of<StarredListings>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        title: const Text("Notifications"),
      ),
      body: starredListings.starredListings.isEmpty
          ? const Center(child: Text('No starred listings'))
          : ListView.builder(
        itemCount: starredListings.starredListings.length,
        itemBuilder: (context, index) {
          final listing = starredListings.starredListings[index];
          return ListTile(
            leading: const Icon(Icons.star, color: Colors.yellow),
            title: Text(listing.address ?? "No Address"),
            subtitle: Text("Price: \$${listing.price}"),
          );
        },
      ),
    );
  }
}