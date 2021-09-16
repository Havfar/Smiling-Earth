import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/pages/post_detailed.dart';

class Post {
  final String urlImage;
  final String title;
  Post(this.urlImage, this.title);
}

class PostWidget extends StatefulWidget {
  const PostWidget({
    Key? key,
    required this.post,
    required this.liked,
  }) : super(key: key);

  final Post post;
  final bool liked;

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late bool liked;
  @override
  Widget build(BuildContext context) {
    liked = false;
    return Card(
      margin: EdgeInsets.only(top: 15),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailedPostPage(post: widget.post)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(widget.post.urlImage)),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'John Doe',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text("2021-09-01",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black54))
                          ]),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(widget.post.title,
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () => setState(() => this.liked = !this.liked),
                      icon: Icon(
                        Icons.thumb_up,
                        color: this.liked ? Colors.blueAccent : Colors.black87,
                      )),
                  IconButton(
                      onPressed: () => print(this.liked.toString()),
                      icon: Icon(Icons.comment))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
