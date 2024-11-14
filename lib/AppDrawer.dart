import 'package:flutter/material.dart';
import 'package:realty_group_project/main.dart';
import 'ListingsPage.dart';

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
            title: const Text('Temp'),
            onTap: () {
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
        builder: (context) => const MyHomePage(title: "Realty",),
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
}
