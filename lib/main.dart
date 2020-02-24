import 'package:blog_app/BlogData.dart';
import 'package:blog_app/spinner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Blog.dart';
import 'blog_screen.dart';
import 'constants.dart';
import 'eye_widget.dart';
import 'login_screen.dart';
import 'UserData.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<FirebaseUser>.value(
            value: FirebaseAuth.instance.onAuthStateChanged, // Provider here
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Blog App',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              accentColor: Colors.blueAccent,
              textTheme: TextTheme(
                  title: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Colors.white),
                  button: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Colors.lightBlue))),
          home: HomeScreen(),
        ));
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  bool onceChecked = false;

  @override
  Widget build(BuildContext context) {
    FirebaseUser _user = Provider.of<FirebaseUser>(context);

    print('User logged in $_user');

//    Widget getScreen() {
//      if (!isCompleted)
//        // ignore: missing_return
//        Future.delayed(Duration(seconds: 2), () {
//          // ignore: missing_return
//          if (_user != null) {
//            setState(() {
//              isCompleted = true;
//            });
//            return LoginScreen();
//          }
//        });
//
//      return CircularProgressIndicator();
//    }

    if (!onceChecked && _user == null) {
      onceChecked = true;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.primaryColor,
          centerTitle: true,
        ),
        body: Container(
          color: Colors.white70,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return _user == null
        ? LoginScreen()
        : MultiProvider(providers: [
            FutureProvider<User>.value(value: UserData.getUserData(_user.uid)),
            StreamProvider<List<Blog>>.value(
              value: BlogData.getBlogList(),
              catchError: (_, err) => null,
              initialData: [Blog(id: '1')],
            ) // Provider here
          ], child: BlogScreen());
  }
}
