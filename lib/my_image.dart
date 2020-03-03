import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  final url;
  final double height;
  final double width;
  final BoxFit boxFit;
  final Alignment alignment;

  MyImage(this.url,
      {this.height,
      this.width,
      this.boxFit = BoxFit.cover,
      this.alignment = Alignment.center});
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      alignment: alignment,
      height: height,
      width: width,
      fit: boxFit,
      imageUrl: url,
      placeholder: (context, url) => Container(
        height: 8,
        width: 8,
        color: Colors.grey,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      errorWidget: (context, url, error) => new Icon(Icons.error),
    );
  }
}
