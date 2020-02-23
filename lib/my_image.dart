import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  final url;

  MyImage(this.url);
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) =>
          Center(child: new CircularProgressIndicator()),
      errorWidget: (context, url, error) => new Icon(Icons.error),
    );
  }
}
