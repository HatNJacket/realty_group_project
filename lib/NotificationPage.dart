import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        title: const Text("Notifications"),
      ),
      body: Center(
        child: Text(
          'No new notifications',
          style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
        ),
      ),
    );
  }
}