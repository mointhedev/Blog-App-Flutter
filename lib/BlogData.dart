import 'package:blog_app/Blog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class BlogData {
  static Stream<List<Blog>> getBlogList() {
    return Firestore.instance
        .collection('blogs')
        .orderBy('time', descending: true)
        .snapshots()
        .map((list) => list.documents
            .map((doc) => Blog.fromMap(doc.data, doc.documentID))
            .toList());
  }
}

class Error implements BlogData {
  Error(this.msg);

  final String msg;
}

class Loading implements BlogData {
  const Loading();
}
