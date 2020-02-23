import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeAgo;
import 'constants.dart';

class SlidingCard extends StatelessWidget {
  final String name; //<-- title of the event
  final double offset;
  final DateTime date; //<-- date of the event
  final String url; //<-- name of the image to be displayed

  const SlidingCard({
    Key key,
    @required this.name,
    @required this.date,
    @required this.url,
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
                    child: Image.network(
                      //<-- main image
                      url,
                      alignment: Alignment(-offset.abs(), 0),
                      fit: BoxFit.none,
                      height: Constants.appBarHeight * 4.9,
                      width: Constants.width,
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
                name: name,
                date: date,
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
  final String name;
  final DateTime date;
  const CardContent(
      {Key key,
      @required this.name,
      @required this.date,
      @required this.offset})
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

            child: Text(name, style: TextStyle(fontSize: 20)),
          ),
          SizedBox(height: 8),
          Transform.translate(
            offset: Offset(32 * offset, 0), //<-- translate the name label

            child: Text(
              DateFormat.yMMMd().format(date),
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
                  onPressed: () {},
                ),
              ),
              Spacer(),
              Transform.translate(
                offset: Offset(32 * offset, 0), //<-- translate the price label

                child: Text(
                  timeAgo.format(date),
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
