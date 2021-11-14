import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:smiling_earth_frontend/cubit/posts/newpost_cubit.dart';
import 'package:smiling_earth_frontend/models/post.dart';
import 'package:smiling_earth_frontend/pages/post_detailed.dart';
import 'package:smiling_earth_frontend/widgets/user_name_widget.dart';

class PublishPostPage extends StatelessWidget {
  final PostDto post;
  PublishPostPage(this.post);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocProvider<NewPostCubit>(
        create: (context) => NewPostCubit(),
        child: Container(
            padding: EdgeInsets.all(30),
            child: BlocBuilder<NewPostCubit, NewPostState>(
              builder: (context, state) {
                if (state is CreatingNewPost) {
                  return Container(
                      margin: EdgeInsets.only(bottom: 50, top: 150),
                      child: Text("Publishing..."));
                } else if (state is NewPostCreated) {
                  return Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(bottom: 50),
                          child: Text("Post is Published")),
                      getPostPreview(),
                      ElevatedButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailedPostPage(postId: state.post.id))),
                          child: Text("Go to Post"))
                    ],
                  );
                } else if (state is NewPostError) {
                  return Container(
                      margin: EdgeInsets.only(bottom: 50, top: 150),
                      child: Text("An error occured. Please try again"));
                }
                return Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(bottom: 50),
                        child: Text("Publish")),
                    getPostPreview(),
                    ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<NewPostCubit>(context)
                              .newPost(this.post);
                        },
                        child: Text("Publish"))
                  ],
                );
              },
            )),
      ),
    );
  }

  Card getPostPreview() {
    return Card(
      margin: EdgeInsets.only(top: 15),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Row(
                children: [
                  Container(
                      width: 50, height: 50, child: FluttermojiCircleAvatar()),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BuildLocalName(),
                        ]),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(post.content,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
            ),
          ],
        ),
      ),
    );
  }
}
