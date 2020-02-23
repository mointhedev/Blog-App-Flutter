class Blog {
  String id;
  String title;
  String imageURL;
  String content;
  DateTime time;

  Blog({this.id, this.title, this.content, this.time, this.imageURL});

  factory Blog.fromMap(Map someData, String id) {
    return Blog(
            id: id ?? '',
            title: someData['title'] ?? '',
            content: someData['content'] ?? '',
            imageURL: someData['image_url'] ?? '',
            time: someData['time'].toDate()) ??
        '';
  }
}
