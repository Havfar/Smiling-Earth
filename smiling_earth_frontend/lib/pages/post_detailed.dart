import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/models/Comment.dart';
import 'package:smiling_earth_frontend/widgets/post.dart';

class DetailedPostPage extends StatefulWidget {
  final Post post;
  DetailedPostPage({Key? key, required this.post}) : super(key: key);

  @override
  _detailedPostPageState createState() => _detailedPostPageState();
}

class _detailedPostPageState extends State<DetailedPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.only(left: 8, right: 8),
              child: PostWidget(post: widget.post, liked: true)),
          buildLikes(),
          buildComments(),
          buildCommentField()
        ],
      ),
    );
  }
}

class buildCommentField extends StatelessWidget {
  const buildCommentField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Flexible(child: TextField()),
          IconButton(onPressed: () => print("comment"), icon: Icon(Icons.send))
        ],
      ),
    );
  }
}

class buildLikes extends StatelessWidget {
  const buildLikes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String Imgurl =
        "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80";
    return Container(
        margin: EdgeInsets.only(left: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              margin: EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                "Likes",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              )),
          Row(
            children: [
              Container(
                  margin: EdgeInsets.only(right: 5),
                  child: CircleAvatar(
                      radius: 15, backgroundImage: NetworkImage(Imgurl))),
              Container(
                  margin: EdgeInsets.only(right: 5),
                  child: CircleAvatar(
                      radius: 15, backgroundImage: NetworkImage(Imgurl))),
              Container(
                  margin: EdgeInsets.only(right: 5),
                  child: CircleAvatar(
                      radius: 15, backgroundImage: NetworkImage(Imgurl))),
              Container(
                  margin: EdgeInsets.only(right: 5),
                  child: CircleAvatar(
                      radius: 15, backgroundImage: NetworkImage(Imgurl))),
              Container(
                  margin: EdgeInsets.only(right: 5),
                  child: CircleAvatar(
                      radius: 15, backgroundImage: NetworkImage(Imgurl))),
            ],
          )
        ]));
  }
}

class buildComments extends StatelessWidget {
  const buildComments({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(top: 20, bottom: 10, left: 10),
              child: Text(
                "Comments",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              )),
          Column(
            children: [
              CommentWidget(
                comment: mockComment,
              )
            ],
          )
        ],
      ),
    );
  }
}

class CommentWidget extends StatelessWidget {
  final Comment comment;

  const CommentWidget({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(color: Colors.black12),
            bottom: BorderSide(color: Colors.black12)),
      ),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
              radius: 20, backgroundImage: NetworkImage(comment.user.image)),
          Container(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.user.name,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Text(comment.comment)
              ],
            ),
          )
        ],
      ),
    );
  }
}
