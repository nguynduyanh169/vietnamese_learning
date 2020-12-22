import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';
import 'dart:core';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/models/noti_message.dart';

class Messaging {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  new FlutterLocalNotificationsPlugin();



  Future initialise() async {
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(
        initSettings);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username');
    if (Platform.isIOS) {
      _firebaseMessaging
          .requestNotificationPermissions(IosNotificationSettings());
    }

    _firebaseMessaging.subscribeToTopic(username);
    _firebaseMessaging.configure(
      //Call when app in foreground and we receive a push notification
        onMessage: (Map<dynamic, dynamic> message) async {
          // //_showNotification(0, message.toString(), message.toString());
          // NotiMessage notiMessage = NotiMessage.fromJson(message);
          // notiMessage.notification.title = 'hello';
          // print(notiMessage.notification.title);
          // if(notiMessage.notification == null){
          //
          // }
          //
          // Map<dynamic, dynamic> details = new Map();
          // details = message.values.elementAt(3).toMap();
          // String title = details.values.elementAt(0).toString();
          // String body = details.values.elementAt(1).toString();
          _showNotification(message);
          return;
        },
        //Call when the app completely closed and it's open from  the push notification directly
        onLaunch: (Map<String, dynamic> message) async {
          // _showNotification(0, message.toString(), message.toString());
          // Map<dynamic, dynamic> details = message.values.elementAt(0);
          // String title = details.values.elementAt(0).toString();
          // String body = details.values.elementAt(1).toString();
          _showNotification(message);
          return;
        },
        //Call when the app in background
        onResume: (Map<String, dynamic> message) async {
          // Map<dynamic, dynamic> details = message.values.elementAt(0);
          // String title = details.values.elementAt(0).toString();
          // String body = details.values.elementAt(1).toString();
          _showNotification(message);
          return;
        });
  }

  Future<void> _showNotification(Map<dynamic, dynamic> message) async {
    print(message.toString());
    NotiMessage notiMessage = NotiMessage.fromJson(message);
    int notificationId = int.parse('1');
        String notificationTitle = notiMessage.notification.title;
    String notificationContent = notiMessage.notification.body;
    String channelId = '1234';
    String channelTitle = 'Android Channel';
    String channelDescription = 'Default Android Channel for notifications';
    Priority notificationPriority = Priority.high;
    Importance notificationImportance = Importance.max;
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      channelId,
      channelTitle,
      channelDescription,
      playSound: true,
      importance: notificationImportance,
      priority: notificationPriority,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails(presentSound: true);
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
