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
      child: Material(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 60,
                width: double.infinity,
                color: Colors.indigo,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: Stack(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Eye(dt.hour == 3 && dt.minute == 33),
                        ],
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => AddBlogScreen()));
                              },
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                FirebaseAuth.instance.signOut();
                              },
                              child: Text(
                                'Sign out',
                                style: Constants.linkTextStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                color: Colors.white,
                child: Center(
                  child: userData == null ? MySpinner() : Text(userData.name),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
