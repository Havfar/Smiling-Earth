import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smiling_earth_frontend/config/web_config.dart';
import 'package:smiling_earth_frontend/models/activity.dart';
import 'package:smiling_earth_frontend/models/post.dart';
import 'package:smiling_earth_frontend/utils/services/secure_storage_service.dart';

class PostCubitMessage {
  final List<PostDto> posts;
  final int statusCode;

  PostCubitMessage(this.posts, this.statusCode);
}

class PostClient {
  final _url = WebConfig.baseUrl;

  Future<PostCubitMessage> getPosts() async {
    String endpoint = '/posts/';
    final token = await UserSecureStorage.getToken();
    final uri = Uri.parse(_url + endpoint);
    try {
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token!});
      if (response.statusCode != 200) {
        throw Exception('Could not fetch posts');
      }
      final json =
          jsonDecode(utf8.decode(response.bodyBytes))["results"] as List;
      final posts = json.map((postJson) {
        return PostDto.fromJson(postJson);
      }).toList();
      return PostCubitMessage(posts, response.statusCode);
    } catch (e) {
      return PostCubitMessage([], -1);
    }
  }

  Future<List<PostDto>> getTeamPosts(int teamId) async {
    String endpoint = '/posts/team/' + teamId.toString() + '/';
    final token = await UserSecureStorage.getToken();
    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token!});
      final json =
          jsonDecode(utf8.decode(response.bodyBytes))["results"] as List;
      final posts = json.map((postJson) {
        return PostDto.fromJson(postJson);
      }).toList();
      return posts;
    } catch (e) {
      throw e;
    }
  }

  Future<List<PostDto>> getUserPosts(int userId) async {
    String endpoint = '/posts/users/' + userId.toString() + '/';
    final token = await UserSecureStorage.getToken();
    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token!});
      final json =
          jsonDecode(utf8.decode(response.bodyBytes))["results"] as List;
      final posts = json.map((postJson) {
        return PostDto.fromJson(postJson);
      }).toList();
      return posts;
    } catch (e) {
      throw e;
    }
  }

  Future<List<PostDto>> getMyPosts() async {
    String endpoint = '/posts/users/self/';
    final token = await UserSecureStorage.getToken();
    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token!});
      final json =
          jsonDecode(utf8.decode(response.bodyBytes))["results"] as List;
      final posts = json.map((postJson) {
        return PostDto.fromJson(postJson);
      }).toList();
      return posts;
    } catch (e) {
      throw e;
    }
  }

  Future<List<DetailedPostDto>> getPost(int id) async {
    String endpoint = '/posts/' + id.toString() + '/';
    final token = await UserSecureStorage.getToken();
    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token!});
      final json = jsonDecode(utf8.decode(response.bodyBytes));
      final post = DetailedPostDto.fromJson(json);
      return [post];
    } catch (e) {
      throw e;
    }
  }

  Future<CommentDto> postComment(CommentDto comment) async {
    String endpoint = '/comment/';
    final token = await UserSecureStorage.getToken();
    try {
      final uri = Uri.parse(_url + endpoint);
      final response = await http.post(uri,
          headers: {"Authorization": "Token " + token!},
          body: comment.toJson());

      // if(response.statusCode = 200){

      // }
      final json = jsonDecode(utf8.decode(response.bodyBytes));

      final newComment = CommentDto.fromJson(json);
      return newComment;
    } catch (e) {
      throw e;
    }
  }

  Future<int> postLike(int postId) async {
    String endpoint = '/likes/';
    final token = await UserSecureStorage.getToken();

    try {
      final uri = Uri.parse(_url + endpoint);
      final data = {'post': postId.toString()};
      final response = await http.post(uri,
          headers: {"Authorization": "Token " + token!}, body: data);
      final Map<String, dynamic> json = jsonDecode(response.body);
      return json['id'] as int;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> deleteLike(int likeId) async {
    String endpoint = '/likes/' + likeId.toString() + '/';
    final token = await UserSecureStorage.getToken();
    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.delete(uri, headers: {"Authorization": "Token " + token!});

      // final Map<String, dynamic> json = jsonDecode(response.body);
      return response.statusCode == 204;
    } catch (e) {
      throw e;
    }
  }

  Future<int> getLike(int postId) async {
    String endpoint = '/liked/' + postId.toString() + '/';

    final token = await UserSecureStorage.getToken();
    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token!});

      final Map<String, dynamic> json = jsonDecode(response.body);

      var results = json['results'] as List;
      if (results.isEmpty) {
        return -1;
      }
      return results.first['id'];
    } catch (e) {
      throw e;
    }
  }

  Future<PostDto> newPost(PostDto post) async {
    String endpoint = '/posts/';
    final token = await UserSecureStorage.getToken();
    try {
      final uri = Uri.parse(_url + endpoint);
      final response = await http.post(uri,
          headers: {"Authorization": "Token " + token!}, body: post.toJson());

      // if(response.statusCode = 200){

      // }
      final json = jsonDecode(utf8.decode(response.bodyBytes));

      final newPost = PostDto.fromJson(json);
      return newPost;
    } catch (e) {
      throw e;
    }
  }

  Future<PostDto> newPostWithActivity(ActivityDto newActivity) async {
    String endpoint = '/posts/';
    final token = await UserSecureStorage.getToken();
    try {
      final uri = Uri.parse(_url + endpoint);
      final response = await http.post(uri, headers: {
        "Authorization": "Token " + token!
      }, body: {
        "content": "Completed an activity",
        "activity": newActivity.id.toString()
      });
      final json = jsonDecode(response.body);

      final newPost = PostDto.fromJson(json);
      return newPost;
    } catch (e) {
      throw e;
    }
  }
}
