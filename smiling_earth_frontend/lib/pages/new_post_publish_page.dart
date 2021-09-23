import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/posts/newpost_cubit.dart';
import 'package:smiling_earth_frontend/models/post.dart';
import 'package:smiling_earth_frontend/pages/post_detailed.dart';
import 'package:smiling_earth_frontend/widgets/post_widget.dart';

class PublishPostPage extends StatelessWidget {
  final PostDto post;
  PublishPostPage(this.post);

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();

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
                      PostWidget(
                        post: this.post,
                        liked: false,
                        clickable: false,
                        isPreview: true,
                      ),
                      ElevatedButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailedPostPage(post: state.post))),
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
                    PostWidget(
                      post: this.post,
                      liked: false,
                      clickable: false,
                      isPreview: true,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<NewPostCubit>(context)
                              .NewPost(this.post);
                        },
                        child: Text("Publish"))
                  ],
                );
              },
            )),
      ),
    );
  }
}
