import 'package:blog_app/my_image.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title:
            SizedBox(height: Constants.appBarHeight * 0.8, child: Eye(false)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: Constants.height - Constants.appBarHeight,
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: Constants.height * 0.3,
                    width: double.infinity,
                    color: Colors.grey,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Hero(
                        tag: widget.blog.id,
                        child: MyImage(
                          widget.blog.imageURL,
                          height: Constants.height * 0.3,
                          width: Constants.width,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: Constants.height * 0.3,
                    width: double.infinity,
                    decoration: new BoxDecoration(
                        gradient: new LinearGradient(
                      colors: [
                        Colors.black26.withOpacity(0.3),
                        Colors.transparent,
                      ],
                      stops: [0.0, 1.0],
                      begin: FractionalOffset.bottomCenter,
                      end: FractionalOffset.center,
                    )),
                  ),
                  Container(
                    height: Constants.height - Constants.appBarHeight,
                    child: ListView(
                      children: <Widget>[
                        Container(
                          color: Colors.transparent,
                          height: Constants.height * 0.24,
                          width: double.infinity,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(Constants.height * 0.06)),
                          child: Container(
                            color: Colors.white,
                            height: Constants.height - Constants.appBarHeight,
                            padding: EdgeInsets.only(
                                top: Constants.height * 0.08,
                                left: Constants.height * 0.04,
                                bottom: Constants.height * 0.04,
                                right: Constants.height * 0.04),
                            child: ListView(
                              children: <Widget>[
                                Text(
                                  widget.blog.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: Constants.height * 0.04),
                                  child: Text(
                                    widget.blog.content,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
