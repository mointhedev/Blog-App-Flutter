import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'constants.dart';

class MySpinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Constants.height / 16,
      width: Constants.width / 3.5,
      child: SpinKitRotatingCircle(
        color: Colors.white70,
        size: Constants.height / 22,
      ),
    );
  }
}
