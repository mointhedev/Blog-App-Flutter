import 'package:blog_app/BlogData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Blog.dart';
import 'blog_screen.dart';
import 'constants.dart';
import 'firebase_notif.dart';
import 'login_screen.dart';
import 'UserData.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: FirebaseAuth.instance.onAuthStateChanged,
      child: MaterialApp(
        navigatorKey: Constants.navKey,
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
      ),
    );
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
