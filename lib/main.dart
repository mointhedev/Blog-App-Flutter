import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'blog_screen.dart';
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

  // bool isCompleted = false;

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

    return _user == null
        ? LoginScreen()
        : MultiProvider(providers: [
            FutureProvider<User>.value(
                value: UserData.getUserData(_user.uid)), // Provider here
          ], child: BlogScreen());
  }
}
