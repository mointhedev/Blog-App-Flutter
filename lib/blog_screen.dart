import 'package:blog_app/UserData.dart';
import 'package:blog_app/constants.dart';
import 'package:blog_app/spinner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'add_blog.dart';

import 'eye_widget.dart';

class BlogScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  Widget build(BuildContext context) {
    User userData = Provider.of<User>(context);
    DateTime dt = DateTime.now();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.primaryColor,
          title:
              SizedBox(height: Constants.appBarHeight * 0.8, child: Eye(false)),
          centerTitle: true,
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => AddBlogScreen()));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: Icon(Icons.add),
                ),
              ),
            )
          ],
        ),
        body: Container(
          child: Center(
            child: Text('Moin'),
          ),
        ),
      ),
    );
  }
}
