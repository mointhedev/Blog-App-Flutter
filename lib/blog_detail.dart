import 'package:blog_app/my_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'Blog.dart';
import 'constants.dart';
import 'eye_widget.dart';

class BlogDetailScreen extends StatefulWidget {
  final Blog blog;

  BlogDetailScreen(this.blog);

  @override
  _BlogDetailScreenState createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  @override
  Widget build(BuildContext context) {
    double screenSize = Constants.height - Constants.appBarHeight;
    DateTime dt = DateTime.now();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
            height: Constants.appBarHeight * 0.8,
            child: Eye(dt.hour == 3 && dt.minute == 33)),
        backgroundColor: Colors.indigo,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
            expandedHeight: screenSize * 0.45,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Container(
                height: screenSize * 0.5,
                width: Constants.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.blog.imageURL))),
                child: Stack(children: <Widget>[
//                  MyImage(
//                    widget.blog.imageURL,
//                    height: Constants.appBarHeight * 6,
//                    width: Constants.width,
//                    boxFit: BoxFit.cover,
//                  ),
                  Container(
                    height: screenSize * 0.5,
                    width: Constants.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
//                          Colors.black,
                          Colors.black,
                          Colors.black54,
                          Colors.black26,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent
                        ])),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 26, bottom: 16, right: 26),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            widget.blog.title,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
//                      ClipRRect(
//                          borderRadius: BorderRadius.only(
//                            topRight: Radius.circular(30),
//                            topLeft: Radius.circular(30),
//                          ),
//                          child: Container(
//                            height: 30,
//                            width: Constants.width,
//                            color: Colors.white,
//                          ))
                    ],
                  )
                ]),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                      child: Container(
                        color: Colors.white,
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                        child: ConstrainedBox(
                          constraints: new BoxConstraints(
                            minHeight: screenSize * 0.55 - 48,
                            minWidth: Constants.width,
                            maxHeight: double.infinity,
                            maxWidth: double.infinity,
                          ),
                          child: Wrap(
                            children: <Widget>[
                              Text(
                                widget.blog.content,
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
