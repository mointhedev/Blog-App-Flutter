import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class Eye extends StatelessWidget {
  final bool isLoading;

  Eye(this.isLoading);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: Constants.height / 9,
        width: Constants.width / 3,
        child: isLoading
            ? FlareActor(
                "assets/eyeon.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: "eyeon",
              )
            : FlareActor(
                "assets/eyeoff.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: "eyeoff",
              ));
  }
}
