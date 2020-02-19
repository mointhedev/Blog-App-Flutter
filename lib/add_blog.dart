import 'dart:io';

import 'package:blog_app/button_widget.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'eye_widget.dart';
import 'spinner.dart';
import 'text_form_field.dart';

class AddBlogScreen extends StatefulWidget {
  @override
  _AddBlogScreenState createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  TextEditingController titleController = TextEditingController();
  File image;
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Cancel',
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
                padding: EdgeInsets.all(8),
                color: Colors.white,
                child: Form(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MyTextFormField(
                            hintText: 'Title',
                            isBackgroundLight: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            image == null
                                ? Text(
                                    'Select Title Image : ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  )
                                : SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: FittedBox(
                                      child: Image.file(image),
                                    ),
                                  ),
                            MyButton(
                              onPressed: () {},
                              text: image == null
                                  ? 'Open Gallery'
                                  : 'Change Picture',
                              color: Colors.blueAccent,
                            ),
                            Container(
                              width: 20,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyTextFormField(
                          maxLines: 12,
                          hintText: 'Content',
                          isBackgroundLight: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: MyButton(
                            text: 'Publish',
                            color: Colors.blueAccent,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
