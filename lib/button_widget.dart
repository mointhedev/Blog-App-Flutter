import 'package:flutter/material.dart';

import 'constants.dart';

class MyButton extends StatelessWidget {
  Function onPressed;
  String text;
  Color color;

  MyButton({this.onPressed, this.text, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(80),
          child: Container(
            height: Constants.height / 16,
            width: Constants.width / 3.5,
            color: color,
            child: Center(
                child: Text(
              text,
              style:
                  color == Colors.white ? null : TextStyle(color: Colors.white),
            )),
          ),
        ));
  }
}
