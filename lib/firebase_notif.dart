import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:blog_app/Blog.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'blog_detail.dart';

class FirebaseNotifications {
  FirebaseMessaging _firebaseMessaging;

  void setUpFirebase() {
    _firebaseMessaging = FirebaseMessaging();
    firebaseCloudMessagingListeners();
    _firebaseMessaging.subscribeToTopic('all');
    print('Subscribed Successfully');
  }

  void firebaseCloudMessagingListeners() {
    if (Platform.isIOS) iOSPermission();

    _firebaseMessaging.getToken().then((token) {
      print('Device Token : $token');
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('On message : $message');
//        Constants.navKey.currentState.push(MaterialPageRoute(
//            builder: (_) =>
//                BlogDetailScreen(Blog.fromMap(message['data'], ''))));
      },
      onResume: (Map<String, dynamic> message) async {
        print('On resume : $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('On launch : $message');
      },
    );
  }

  void unsubscribe() {
    _firebaseMessaging.unsubscribeFromTopic('all');
  }

  void iOSPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}
