import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';
import 'dart:core';

import 'package:shared_preferences/shared_preferences.dart';

class Messaging {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  new FlutterLocalNotificationsPlugin();

  Future initialise() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username');
    if (Platform.isIOS) {
      _firebaseMessaging
          .requestNotificationPermissions(IosNotificationSettings());
    }

    _firebaseMessaging.subscribeToTopic(username);
    _firebaseMessaging.configure(
      //Call when app in foreground and we receive a push notification
        onMessage: (Map<String, dynamic> message) async {
          Map<dynamic, dynamic> details = message.values.elementAt(0);
          String title = details.values.elementAt(0).toString();
          String body = details.values.elementAt(1).toString();
          _showNotification(0, title, body);
          return;
        },
        //Call when the app completely closed and it's open from  the push notification directly
        onLaunch: (Map<String, dynamic> message) async {
          Map<dynamic, dynamic> details = message.values.elementAt(0);
          String title = details.values.elementAt(0).toString();
          String body = details.values.elementAt(1).toString();
          _showNotification(0, title, body);
          return;
        },
        //Call when the app in background
        onResume: (Map<String, dynamic> message) async {
          Map<dynamic, dynamic> details = message.values.elementAt(0);
          String title = details.values.elementAt(0).toString();
          String body = details.values.elementAt(1).toString();
          _showNotification(0, title, body);
          return;
        });
  }

  Future<void> _showNotification(int notificationId,
      String notificationTitle,
      String notificationContent) async {
    String channelId = '1234';
    String channelTitle = 'Android Channel';
    String channelDescription = 'Default Android Channel for notifications';
    Priority notificationPriority = Priority.high;
    Importance notificationImportance = Importance.max;
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      channelId,
      channelTitle,
      channelDescription,
      playSound: false,
      importance: notificationImportance,
      priority: notificationPriority,
    );
    var iOSPlatformChannelSpecifics =
    new IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        notificationId,
        notificationTitle,
        notificationContent,
        platformChannelSpecifics
    );
  }
}
