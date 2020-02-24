import 'package:blog_app/UserData.dart';
import 'package:blog_app/constants.dart';
import 'package:blog_app/my_image.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'blog_detail.dart';
import 'constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'add_blog.dart';
import 'Blog.dart';
import 'eye_widget.dart';
import 'sliding_card.dart';

class BlogScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Constants.setDeviceSize(context);
    var blogs = Provider.of<List<Blog>>(context);
    print('Blogs: $blogs');
//    print('Blog title ${blogs.first.title}');
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
        body: blogs == null
            ? Container(child: Center(child: Text('Error Loading Data')))
            : blogs[0].id == '1'
                ? Container(child: Center(child: CircularProgressIndicator()))
                : ListView(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(18),
                          child: Text(
                            'Recent',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          )),
                      Container(
                          child: SizedBox(
                        height: Constants.height * 0.6,
                        child: PageView(
                            controller: pageController,
                            children: blogs
                                .getRange(0, 3)
                                .map((blog) => SlidingCard(
                                      blog: blog,
                                      offset: pageOffset - blogs.indexOf(blog),
                                    ))
                                .toList()),
                      )),
                      Container(
                          padding: EdgeInsets.all(18),
                          child: Text(
                            'Top',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          )),
                      Container(
                        height: Constants.height - (Constants.appBarHeight * 2),
                        child: ListView(
                          children: blogs.reversed
                              .map((blog) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 2),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    BlogDetailScreen(blog)));
                                      },
                                      child: Card(
                                        elevation: 4,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(32)),
                                        child: Container(
                                          height: Constants.appBarHeight * 2,
                                          padding: EdgeInsets.all(17),
                                          child: Row(
                                            children: <Widget>[
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.horizontal(
                                                        left: Radius.circular(
                                                            20)),
                                                child: SizedBox(
                                                    height:
                                                        Constants.appBarHeight *
                                                            1.5,
                                                    width:
                                                        Constants.appBarHeight *
                                                            1.5,
                                                    child: FittedBox(
                                                        child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius
                                                              .horizontal(
                                                                  left: Radius
                                                                      .circular(
                                                                          20),
                                                                  right: Radius
                                                                      .circular(
                                                                          20)),
                                                      child: MyImage(
                                                        blog.imageURL,
                                                        height: Constants
                                                                .appBarHeight *
                                                            1.5,
                                                        width: Constants
                                                                .appBarHeight *
                                                            1.5,
                                                      ),
                                                    ))),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      blog.title,
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5),
                                                      child: Text(
                                                        DateFormat.yMMMd()
                                                            .format(blog.time),
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      )
                    ],
                  ),
      ),
    );
  }
}
