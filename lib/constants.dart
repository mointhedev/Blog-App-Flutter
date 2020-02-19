import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Constants {
  static double height;
  static double width;

  static setDeviceSize(context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
  }

  static TextStyle fieldTextStyle = TextStyle(color: Colors.white70);
  static TextStyle normalTextStyle = TextStyle(color: Colors.white70);
  static TextStyle linkTextStyle = TextStyle(color: Colors.white);

  static showErrorMessage(context, String errorMessage) {
    Alert(context: context, title: 'Error', desc: errorMessage, buttons: [
      DialogButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        color: Colors.blueAccent,
        child: Text(
          'CANCEL',
          style: TextStyle(color: Colors.white),
        ),
        width: Constants.width / 3.5,
        radius: BorderRadius.circular(80),
      ),
    ]).show();
  }
}
