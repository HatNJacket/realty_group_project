import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationHandler {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  String? payload;

  Future<void> initializeNotifications() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        _onSelectNotification(notificationResponse.payload);
      },
    );

    if (Platform.isAndroid) {
      await _requestNotificationPermission();
    }
  }

  Future<void> _requestNotificationPermission() async {
    if (Platform.isAndroid) {
      // Check if notification permission is denied
      if (await Permission.notification.isDenied) {
        // Request notification permission from the user
        PermissionStatus status = await Permission.notification.request();
        if (status.isDenied) {
          print("Notification permission denied");
        } else if (status.isGranted) {
          print("Notification permission granted");
        }
      }
    }
  }

  Future<void> notificationNow(String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,  // Notification ID
      'Realty',  // Title of the notification
      body ?? 'This is a simple notification.',  // Body of the notification
      platformChannelSpecifics,  // Notification details (Android)
      payload: 'Notification Payload',  // Payload to handle notification taps
    );
  }

  Future<void> _onSelectNotification(String? payload) async {
    if (payload != null) {
      print('Notification payload: $payload');
    }
  }
}