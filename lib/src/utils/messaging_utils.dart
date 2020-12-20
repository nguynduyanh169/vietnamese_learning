import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';
import 'dart:core';

class Messaging {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Future initialise() async {
    if (Platform.isIOS) {
      _firebaseMessaging
          .requestNotificationPermissions(IosNotificationSettings());
    }

    _firebaseMessaging.subscribeToTopic('topic');
    _firebaseMessaging.configure(
        //Call when app in foreground and we receive a push notification
        onMessage: (Map<String, dynamic> message) async {
      print("On message: $message");
    },
        //Call when the app completely closed and it's open from  the push notification directly
        onLaunch: (Map<String, dynamic> message) async {
      print("On message: $message");
    },
        //Call when the app in background
        onResume: (Map<String, dynamic> message) async {
      print("On message: $message");
    });
  }
}
