import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/posts/newcomment_cubit.dart';
import 'package:smiling_earth_frontend/cubit/posts/posts_cubit.dart';
import 'package:smiling_earth_frontend/models/post.dart';
import 'package:smiling_earth_frontend/pages/home_page.dart';
import 'package:smiling_earth_frontend/widgets/post_widget.dart';

class DetailedPostPage extends StatefulWidget {
  final PostDto post;
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
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HomePage(),
            )),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        bottomNavigationBar: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: BlocProvider<NewcommentCubit>(
                create: (context) => NewcommentCubit(),
                child: buildCommentField(post: widget.post))),
        body: BlocProvider<PostDetailedCubit>(
            create: (context) => PostDetailedCubit()..getPost(widget.post.id),
            child: Container(
              child: BlocBuilder<PostDetailedCubit, List<DetailedPostDto>>(
                  builder: (context, posts) {
                if (posts.isEmpty) {
                  return Text('loading');
                }
                return ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 8, right: 8),
                      child: PostWidget(
                        clickable: false,
                        post: posts.first.toPostDto(),
                        liked: false,
                      ),
                    ),
                    buildLikes(likes: posts.first.likes),
                    buildComments(comments: posts.first.comments),
                  ],
                );
              }),
            )));
  }
}

class buildCommentField extends StatelessWidget {
  final PostDto post;
  const buildCommentField({
    Key? key,
    required PostDto this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();

    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black38)),
          color: Colors.white70),
      height: 70,
      padding: EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Flexible(
              child: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: "Write a comment..."),
          )),
          IconButton(
              onPressed: () {
                final comment = _controller.text;
                BlocProvider.of<NewcommentCubit>(context)
                    .newComment(CommentDto(comment: comment, post: this.post));

                // used to reload current page
                Navigator.pop(context); // pop current page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailedPostPage(post: this.post)),
                ); // push it back in
              },
              icon: Icon(Icons.send))
        ],
      ),
    );
  }
}

class buildLikes extends StatelessWidget {
  final List<LikeDto> likes;
  const buildLikes({
    required this.likes,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            children: likes
                .map((like) => Container(
                    child: CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(like.user!.image))))
                .toList(),
          )
        ]));
  }
}

class buildComments extends StatelessWidget {
  final List<CommentDto> comments;
  const buildComments({
    required this.comments,
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
            children: comments
                .map((comment) => CommentWidget(
                      comment: comment,
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}

class CommentWidget extends StatelessWidget {
  final CommentDto comment;

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
              radius: 20, backgroundImage: NetworkImage(comment.user!.image)),
          Container(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.user!.first_name,
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
