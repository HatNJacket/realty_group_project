import 'package:flutter/material.dart';
import 'package:realty_group_project/NotificationHandler.dart';
import 'package:realty_group_project/SearchHistory.dart';
import 'ListingsPage.dart';
import 'FavouriteListings.dart';

class AppDrawer extends StatefulWidget {
  NotificationHandler notificationHandler;

  AppDrawer({super.key, required this.notificationHandler});

  @override
  AppDrawerState createState() => AppDrawerState();
}

class AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Center(
              child: Text(
                'Realty',
                style: TextStyle(color: Colors.white, fontSize: 36),
              ),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              _openHomePage();
            },
          ),
          ListTile(
            title: const Text('Favourite Listings'),
            onTap: () {
              Navigator.pop(context);
              _openNotificationPage();
            },
          ),
          ListTile(
            title: const Text('Search History'),
            onTap: () {
              Navigator.pop(context);
              _openTempPage();
            },
          ),
        ],
      ),
    );
  }

  void _openHomePage() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ListingsPage(),
      ),
    );
  }

  void _openNotificationPage() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavouriteListings(notificationHandler: widget.notificationHandler,),
      ),
    );
  }

  void _openTempPage() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SearchHistory(),
      ),
    );
  }
}