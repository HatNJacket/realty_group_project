import 'package:flutter/material.dart';
import 'package:realty_group_project/AddListingPage.dart';
import 'package:realty_group_project/TempPage.dart';
import 'package:realty_group_project/main.dart'
import 'ListingsPage.dart';
import 'NotificationPage.dart'; // New screen for notifications
// import 'TempPage.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

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
            title: const Text('View Listings'),
            onTap: () {
              Navigator.pop(context);
              _openListingsPage();
            },
          ),
          ListTile(
            title: const Text('Notifications'),
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

  void _openListingsPage() async {
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
        builder: (context) => const NotificationPage(),
      ),
    );
  }

  void _openTempPage() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TempPage(),
      ),
    );
  }
}