import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/models/post.dart';
import 'package:smiling_earth_frontend/models/user.dart';
import 'package:smiling_earth_frontend/pages/new_post_publish_page.dart';

class NewPostPage extends StatelessWidget {
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
      body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(bottom: 50),
                  child: Text("Create a new post")),
              SizedBox(
                height: 100,
                child: TextFormField(
                    maxLines: 5,
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'New Post',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.length < 5) {
                        return 'Enter at least 5 characters';
                      } else {
                        return null;
                      }
                    },
                    maxLength: 300),
              ),
              ElevatedButton(
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PublishPostPage(PostDto(
                                id: -1,
                                commentsCount: 0,
                                content: _controller.value.text,
                                likesCount: 0,
                                user: UserProfileDto(
                                    firstName: "Name",
                                    lastName: 'Name',
                                    userId: -1),
                                timestamp: ''))),
                      ),
                  child: Text("Preview Post"))
            ],
          )),
    );
  }
}
