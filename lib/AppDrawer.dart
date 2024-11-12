import 'package:flutter/material.dart';
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

  void _openListingsPage() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ListingsPage(),
      ),
    );
  }
}
