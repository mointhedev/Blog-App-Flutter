import 'package:blog_app/blog_detail.dart';
import 'package:blog_app/my_image.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeAgo;
import 'Blog.dart';
import 'constants.dart';

class SlidingCard extends StatelessWidget {
  final Blog blog; //<-- title of the event
  final double offset;
  //<-- name of the image to be displayed

  const SlidingCard({
    Key key,
    @required this.blog,
    @required this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
      child: Card(
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
        elevation: 8,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32)), //<--custom shape
        child: Column(
          children: <Widget>[
            ClipRRect(
              //<--clipping image
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              child: SizedBox(
                height: Constants.appBarHeight * 4.2,
                width: Constants.width * 0.7,
                child: FittedBox(
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(32)),
                    child: Hero(
                      tag: blog.id,
                      child: MyImage(
                        //<-- main image
                        blog.imageURL,
                        alignment: Alignment(-offset.abs(), 0),
                        boxFit: BoxFit.none,
                        height: Constants.appBarHeight * 4.9,
                        width: Constants.width,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: CardContent(
                //<--replace the Container with CardContent
                offset: gauss,
                blog: blog,
              ),
              //<-- will be replaced soon :)
            ),
          ],
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final double offset;
  final Blog blog;
  const CardContent({Key key, @required this.blog, @required this.offset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Transform.translate(
            offset: Offset(8 * offset, 0), //<-- translate the name label

            child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(blog.title, style: TextStyle(fontSize: 16))),
          ),
          SizedBox(height: 8),
          Transform.translate(
            offset: Offset(32 * offset, 0), //<-- translate the name label

            child: Text(
              DateFormat.yMMMd().format(blog.time),
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Spacer(),
          Row(
            children: <Widget>[
              Transform.translate(
                offset: Offset(48 * offset, 0),
                child: RaisedButton(
                  color: Color(0xFF162A49),
                  child: Transform.translate(
                      offset: Offset(24 * offset, 0), child: Text('Read')),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BlogDetailScreen(blog)));
                  },
                ),
              ),
              Spacer(),
              Transform.translate(
                offset: Offset(32 * offset, 0), //<-- translate the price label

                child: Text(
                  timeAgo.format(blog.time),
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(width: 16),
            ],
          )
        ],
      ),
    );
  }
}
