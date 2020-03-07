import 'dart:io';
import 'package:blog_app/button_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool hasError = false;
  FocusNode titleNode = FocusNode();
  FocusNode contentNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    DateTime dt = DateTime.now();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.primaryColor,
          title: SizedBox(
              height: Constants.appBarHeight * 0.8,
              child: Eye(dt.hour == 3 && dt.minute == 33)),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            titleNode.unfocus();
            contentNode.unfocus();
          },
          child: Container(
            width: double.infinity,
            height: Constants.height - Constants.appBarHeight,
            color: Colors.white,
            padding: EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyTextFormField(
                        // ignore: missing_return
                        validator: (value) {
                          // ignore: missing_return
                          if (value.toString().trim().length == 0) {
                            return 'Please enter a title';
                          }

                          if (value.toString().trim().length == 0) {
                            return 'Title has to be less than';
                          }
                        },
                        onChanged: (value) {
                          if (hasError) _formKey.currentState.validate();
                        },
                        controller: titleController,
                        maxLength: 45,
                        focusNode: titleNode,
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
                        SizedBox(
                          width: Constants.width / 10,
                        ),
                        image == null
                            ? Text(
                                'Select Title Image : ',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            : SizedBox(
                                height: Constants.appBarHeight,
                                width: Constants.appBarHeight * 1.5,
                                child: FittedBox(
                                  child: Image.file(image),
                                ),
                              ),
                        MyButton(
                          onPressed: () async {
                            var myImage = await ImagePicker.pickImage(
                                source: ImageSource.gallery);

                            setState(() {
                              image = myImage;
                            });
                          },
                          text:
                              image == null ? 'Open Gallery' : 'Change Picture',
                          color: Colors.blueAccent,
                        ),
                        SizedBox(
                          width: Constants.width / 10,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyTextFormField(
                      focusNode: contentNode,
                      controller: contentController,
                      maxLines: 12,
                      hintText: 'Content',
                      isBackgroundLight: true,
                      onChanged: (value) {
                        if (hasError) _formKey.currentState.validate();
                      },
                      // ignore: missing_return
                      validator: (value) {
                        // ignore: missing_return
                        if (value.toString().trim().length == 0) {
                          return 'Please enter some content';
                        }

                        if (value.toString().trim().length < 150) {
                          return "Enter at least 150 letters. Remaining: ${value.toString().trim().length - 150}";
                        }
                      },
                    ),
                  ),
                  _isLoading
                      ? MySpinner(
                          color: Colors.blueAccent,
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: MyButton(
                              onPressed: () async {
                                if (!_formKey.currentState.validate()) {
                                  setState(() {
                                    hasError = true;
                                  });
                                  return;
                                }
                                if (image == null) {
                                  Constants.showErrorMessage(
                                      context, 'Please select an image');
                                  return;
                                }

                                String urlLink;

                                if (image != null) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  try {
                                    print('Firestorage reference');
                                    StorageReference storageReference =
                                        FirebaseStorage.instance
                                            .ref()
                                            .child(DateTime.now().toString());
                                    print('Firestorage uploadTask');

                                    //upload the file to Firebase Storage
                                    final StorageUploadTask uploadTask =
                                        storageReference.putFile(image);

                                    print('Firestorage Snapshot');

                                    final StorageTaskSnapshot downloadUrl =
                                        (await uploadTask.onComplete);

                                    print('Firestorage Getting URL');

                                    urlLink = (await downloadUrl.ref
                                        .getDownloadURL());
                                  } catch (error) {
                                    Constants.showErrorMessage(
                                        context, error.toString());
                                  }
                                }

                                Firestore.instance.collection('blogs').add({
                                  'title': titleController.text.trim(),
                                  'image_url': urlLink,
                                  'content': contentController.text.trim(),
                                  'time': FieldValue.serverTimestamp()
                                }).then((value) {
                                  _formKey.currentState.reset();
                                  titleController.clear();
                                  contentController.clear();
                                  setState(() {
                                    image = null;

                                    _isLoading = false;
                                  });
                                }).catchError((error) {
                                  Constants.showErrorMessage(
                                      context, error.toString());
                                });

                                setState(() {
                                  _isLoading = false;
                                });
                              },
                              text: 'Publish',
                              color: Colors.blueAccent,
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
