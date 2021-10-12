import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smiling_earth_frontend/config/web_config.dart';
import 'package:smiling_earth_frontend/models/user.dart';

class UserClient {
  final _url = WebConfig.baseUrl;
  final token = "1ef4424ee40e7f213893ffe0c1da4cff1d8b5797";

  Future<List<UserProfileDto>> getFollowers() async {
    String endpoint = '/followers/';
    final uri = Uri.parse(_url + endpoint);
    final response =
        await http.get(uri, headers: {"Authorization": "Token " + token});
    final json = jsonDecode(utf8.decode(response.bodyBytes))["results"] as List;
    final users = json.map((followersJson) {
      return UserProfileDto.fromJson(followersJson['user']);
    }).toList();
    return users;
  }

  Future<List<UserProfileDto>> getFollowing() async {
    String endpoint = '/following/';
    final uri = Uri.parse(_url + endpoint);
    final response =
        await http.get(uri, headers: {"Authorization": "Token " + token});
    final json = jsonDecode(utf8.decode(response.bodyBytes))["results"] as List;
    final users = json.map((followingJson) {
      return UserProfileDto.fromJson(followingJson['user']);
    }).toList();
    return users;
  }

  Future<List<UserProfileDto>> getNotFollowing() async {
    String endpoint = '/not-following/';
    final uri = Uri.parse(_url + endpoint);
    final response =
        await http.get(uri, headers: {"Authorization": "Token " + token});
    final json = jsonDecode(utf8.decode(response.bodyBytes))["results"] as List;
    final users = json.map((userJson) {
      return UserProfileDto.fromJson(userJson);
    }).toList();
    return users;
  }
}
