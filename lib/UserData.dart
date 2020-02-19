import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class UserData extends ChangeNotifier {
  static Future<User> getUserData(String userId) {
    return Firestore.instance
        .collection('users')
        .document(userId)
        .get()
        .then((value) => User.fromMap(value.data));
  }
}

class User {
  final String email;
  final String name;

  User({this.email, this.name});

  factory User.fromMap(Map<String, dynamic> userData) {
    return User(email: userData['email'], name: userData['name']);
  }
}
