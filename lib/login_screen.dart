import 'package:blog_app/eye_widget.dart';
import 'package:blog_app/spinner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'button_widget.dart';
import 'constants.dart';
import 'text_form_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  bool _isSignUp = false;
  bool _hasFieldError = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    Constants.setDeviceSize(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              focusNode1.unfocus();
              focusNode2.unfocus();
              focusNode3.unfocus();
            },
            child: Container(
              color: Colors.indigo,
              height: Constants.height,
              child: Column(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Center(
                      child: Padding(
                          padding: EdgeInsets.only(top: Constants.height / 14),
                          child: Eye(_isLoading)),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            vertical: constraints.maxHeight * 0.1,
                            horizontal: constraints.maxWidth * 0.12,
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                _isSignUp
                                    ? MyTextFormField(
                                        onChanged: (value) {
                                          if (value != '' && _hasFieldError)
                                            _formKey.currentState.validate();
                                        },
                                        // ignore: missing_return
                                        validator: (value) {
                                          if (value == '' || value == null)
                                            return 'Please enter a name';
                                        },
                                        onFieldSubmitted: (_) =>
                                            FocusScope.of(context)
                                                .requestFocus(focusNode2),
                                        focusNode: focusNode1,
                                        controller: nameController,
                                        hintText: 'Name',
                                      )
                                    : null,
                                MyTextFormField(
                                  onChanged: (value) {
                                    if (value != '' && _hasFieldError)
                                      _formKey.currentState.validate();
                                  },
                                  // ignore: missing_return
                                  validator: (value) {
                                    if (value == '' || value == null)
                                      return 'Please enter an email';
                                    if (!value.contains('@'))
                                      return 'Please enter a valid email';
                                  },
                                  onFieldSubmitted: (_) =>
                                      FocusScope.of(context)
                                          .requestFocus(focusNode3),
                                  focusNode: focusNode2,
                                  controller: emailController,
                                  hintText: 'Email',
                                ),
                                MyTextFormField(
                                    // ignore: missing_return
                                    validator: (value) {
                                      if (value == '' || value == null)
                                        return 'Password must be greater than 5 characters';
                                    },
                                    onChanged: (value) {
                                      if (value.toString().trim() != '' &&
                                          _hasFieldError)
                                        _formKey.currentState.validate();
                                    },
                                    obscureText: true,
                                    onFieldSubmitted: (_) {
                                      focusNode3.unfocus();
                                    },
                                    focusNode: focusNode3,
                                    controller: passController,
                                    hintText: "Password"),
                                _isLoading
                                    ? MySpinner()
                                    : MyButton(
                                        text: _isSignUp ? "SIGN UP" : "LOGIN",
                                        onPressed: () {
                                          focusNode1.unfocus();
                                          focusNode2.unfocus();
                                          focusNode3.unfocus();
                                          setState(() {
                                            _hasFieldError = !_formKey
                                                .currentState
                                                .validate();
                                          });
                                          if (_hasFieldError) {
                                            return;
                                          }
                                          setState(() {
                                            _isLoading = true;
                                          });

                                          final String email =
                                              emailController.text.trim();
                                          final String pass =
                                              passController.text.trim();
                                          final String name =
                                              nameController.text.trim();

                                          _isSignUp
                                              ? _auth
                                                  .createUserWithEmailAndPassword(
                                                      email: email,
                                                      password: pass)
                                                  .then((value) {
                                                  _firestore
                                                      .collection('users')
                                                      .document(value.user.uid)
                                                      .setData({
                                                        'email': email,
                                                        'name': name
                                                      })
                                                      .then((value) {})
                                                      .catchError((error) {
                                                        setState(() {
                                                          _isLoading = false;
                                                        });
                                                        String errorMessage =
                                                            error.toString();

                                                        Constants
                                                            .showErrorMessage(
                                                                context,
                                                                errorMessage);
                                                      });
                                                })
                                              : _auth
                                                  .signInWithEmailAndPassword(
                                                      email: email,
                                                      password: pass)
                                                  .then((value) {})
                                                  .catchError((error) {
                                                  setState(() {
                                                    _isLoading = false;
                                                  });
                                                  String errorMessage =
                                                      error.toString();

                                                  if (errorMessage
                                                      .contains('NOT_FOUND'))
                                                    errorMessage =
                                                        'User doesn\'t exist.';
                                                  else if (errorMessage
                                                      .contains(
                                                          'INVALID_EMAIL'))
                                                    errorMessage =
                                                        'Invalid email';
                                                  else if (errorMessage
                                                      .contains(
                                                          'INVALID_PASSWORD'))
                                                    errorMessage =
                                                        'Invalid password';

                                                  Constants.showErrorMessage(
                                                      context, errorMessage);
                                                });
                                        },
                                      ),
                                GestureDetector(
                                    onTap: _isLoading
                                        ? () {}
                                        : () {
                                            _formKey.currentState.reset();
                                            setState(() {
                                              _isSignUp = !_isSignUp;
                                            });
                                          },
                                    child: Text(
                                      _isSignUp ? 'Sign In Instead' : "Join Us",
                                      style: Constants.linkTextStyle,
                                    ))
                              ].where((o) => o != null).toList(),
                            ),
                          ),
                        );
                      },
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
