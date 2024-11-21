import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'StarredListings.dart';
import 'NotificationHandler.dart';

class FavouriteListings extends StatelessWidget {
  final NotificationHandler notificationHandler;

  const FavouriteListings({super.key, required this.notificationHandler});

  @override
  Widget build(BuildContext context) {
    final starredListings = Provider.of<StarredListings>(context);

    starredListings.addListener(() {
      for (var listing in starredListings.starredListings) {
        notificationHandler.notificationNow(
          "Listing updated: ${listing.address ?? 'No Address'} - Bid Price: \$${listing.highestBid}",
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        title: const Text("Favourite Listings"),
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