import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:smiling_earth_frontend/cubit/posts/like_cubit.dart';
import 'package:smiling_earth_frontend/models/avatar.dart';
import 'package:smiling_earth_frontend/models/post.dart';
import 'package:smiling_earth_frontend/pages/post_detailed.dart';
import 'package:smiling_earth_frontend/widgets/circle_icon.dart';

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
                  builder: (context) =>
                      DetailedPostPage(postId: widget.post.id)),
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
                    Container(
                        height: 60,
                        width: 60,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                        ),
                        child: Avatar.toSvg(widget.post.user!.avatar)),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.post.user!.firstName +
                                  " " +
                                  widget.post.user!.lastName,
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
              this.widget.post.challenge != null
                  ? ChallengesPost(widget: widget)
                  : Text(""),
              this.widget.isPreview
                  ? Text("")
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BlocProvider(
                          create: (context) =>
                              LikeCubit()..getLiked(this.widget.post.id),
                          child: BuildLikeButton(post: this.widget.post),
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

class ChallengesPost extends StatelessWidget {
  const ChallengesPost({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final PostWidget widget;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        child: Card(
          color: Colors.blue.shade100,
          child: Container(
            width: 250,
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleIcon(
                    onTap: null,
                    emoji: widget.post.challenge!.symbol,
                    backgroundColor: Colors.white),
                Text(widget.post.challenge!.title,
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BuildLikeButton extends StatefulWidget {
  final PostDto post;
  const BuildLikeButton({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<BuildLikeButton> createState() => _BuildLikeButtonState(this.post);
}

class _BuildLikeButtonState extends State<BuildLikeButton> {
  final PostDto post;

  void like(LikeState state) {
    if (state is HasNotLikedPost) {
      BlocProvider.of<LikeCubit>(context).newLike(LikeDto(post: this.post));
    } else if (state is HasLikedPost) {
      BlocProvider.of<LikeCubit>(context).deleteLike(state.likeId);
    }
  }

  _BuildLikeButtonState(this.post);
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

class PostSkeletonWidget extends StatelessWidget {
  const PostSkeletonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
        shimmerColor: Colors.white38,
        shimmerDuration: 4000,
        child: Card(
            child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleIconSkeleton(),
                  SizedBox(width: 20),
                  Container(
                      height: 10,
                      width: 40,
                      decoration: BoxDecoration(color: Colors.grey)),
                  SizedBox(width: 10),
                  Container(
                      height: 10,
                      width: 70,
                      decoration: BoxDecoration(color: Colors.grey))
                ],
              ),
              Container(
                  height: 10,
                  width: 200,
                  decoration: BoxDecoration(color: Colors.grey)),
              SizedBox(height: 5),
              Container(
                  height: 10,
                  width: 150,
                  decoration: BoxDecoration(color: Colors.grey)),
              SizedBox(height: 5),
              Container(
                  height: 10,
                  width: 250,
                  decoration: BoxDecoration(color: Colors.grey))
            ],
          ),
        )));
  }
}
