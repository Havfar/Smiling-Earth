import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/posts/like_cubit.dart';
import 'package:smiling_earth_frontend/models/post.dart';
import 'package:smiling_earth_frontend/pages/post_detailed.dart';

class PostWidget extends StatefulWidget {
  const PostWidget(
      {Key? key,
      this.isPreview = false,
      required this.post,
      required this.liked,
      required this.clickable})
      : super(key: key);

  final PostDto post;
  final bool liked;
  final bool clickable;
  final bool isPreview;

  @override
  _PostWidgetState createState() => _PostWidgetState(this.liked);
}

class _PostWidgetState extends State<PostWidget> {
  bool liked;
  _PostWidgetState(this.liked);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 15),
      child: InkWell(
        onTap: () {
          if (widget.clickable) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailedPostPage(post: widget.post)),
            );
          }
        },
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
                        backgroundImage: NetworkImage(widget.post.user!.image)),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.post.user!.first_name +
                                  " " +
                                  widget.post.user!.last_name,
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
                child: Text(widget.post.content,
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              ),
              this.widget.post.activity != null
                  ? Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text(widget.post.activity!.title,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400)),
                    )
                  : Text(""),
              this.widget.isPreview
                  ? Text("")
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BlocProvider(
                          create: (context) =>
                              LikeCubit()..getLiked(this.widget.post.id),
                          child: buildLikeButton(post: this.widget.post),
                        ),
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

class buildLikeButton extends StatefulWidget {
  final PostDto post;
  const buildLikeButton({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<buildLikeButton> createState() => _buildLikeButtonState(this.post);
}

class _buildLikeButtonState extends State<buildLikeButton> {
  final PostDto post;

  void like(LikeState state) {
    if (state is HasNotLikedPost) {
      BlocProvider.of<LikeCubit>(context).newLike(LikeDto(post: this.post));
    } else if (state is HasLikedPost) {
      BlocProvider.of<LikeCubit>(context).deleteLike(state.likeId);
    }
  }

  _buildLikeButtonState(this.post);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikeCubit, LikeState>(
      builder: (context, state) {
        if (state is CheckingPostHasBeenLiked) {
          return Text("Loading");
        }
        return Container(
          child: IconButton(
              onPressed: () => like(state),
              icon: Icon(
                Icons.thumb_up,
                color:
                    state is HasLikedPost ? Colors.blueAccent : Colors.black45,
              )),
        );
      },
    );
  }
}
