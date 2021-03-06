import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smiling_earth_frontend/config/web_config.dart';
import 'package:smiling_earth_frontend/models/avatar.dart';
import 'package:smiling_earth_frontend/models/emission.dart';
import 'package:smiling_earth_frontend/models/user.dart';
import 'package:smiling_earth_frontend/utils/services/secure_storage_service.dart';

class UserClient {
  final _url = WebConfig.baseUrl;

  Future<bool> follow(int userId) async {
    String endpoint = '/follow/$userId/';
    final token = await UserSecureStorage.getToken();

    final uri = Uri.parse(_url + endpoint);
    final response =
        await http.post(uri, headers: {"Authorization": "Token " + token!});

    return response.statusCode == 200;
  }

  Future<bool> unfollow(int userId) async {
    String endpoint = '/unfollow/$userId/';
    final token = await UserSecureStorage.getToken();

    final uri = Uri.parse(_url + endpoint);
    final response =
        await http.post(uri, headers: {"Authorization": "Token " + token!});

    return response.statusCode == 200;
  }

  Future<List<FollowerDto>> getFollowers() async {
    String endpoint = '/followers/';
    final token = await UserSecureStorage.getToken();

    final uri = Uri.parse(_url + endpoint);
    final response =
        await http.get(uri, headers: {"Authorization": "Token " + token!});
    final json = jsonDecode(utf8.decode(response.bodyBytes))["results"] as List;
    final users = json.map((followerJson) {
      return FollowerDto(
          isFollowing: followerJson['is_following'],
          user: UserProfileDto.fromJson(followerJson['followed_by']));
    }).toList();
    return users;
  }

  Future<List<FollowerDto>> getFollowing() async {
    String endpoint = '/following/';
    final token = await UserSecureStorage.getToken();

    final uri = Uri.parse(_url + endpoint);
    final response =
        await http.get(uri, headers: {"Authorization": "Token " + token!});
    final json = jsonDecode(utf8.decode(response.bodyBytes))["results"] as List;
    final users = json.map((followingJson) {
      return FollowerDto(
          isFollowing: true,
          user: UserProfileDto.fromJson(followingJson['user']));
    }).toList();
    return users;
  }

  Future<List<FollowerDto>> getNotFollowing() async {
    String endpoint = '/not-following/';
    final token = await UserSecureStorage.getToken();

    final uri = Uri.parse(_url + endpoint);
    final response =
        await http.get(uri, headers: {"Authorization": "Token " + token!});
    final json = jsonDecode(utf8.decode(response.bodyBytes))["results"] as List;
    final users = json.map((userJson) {
      return FollowerDto(
          isFollowing: false, user: UserProfileDto.fromJson(userJson));
    }).toList();
    return users;
  }

  Future<UserProfileDetailedDto> getProfile(int userId) async {
    String endpoint = '/users/' + userId.toString() + '/';
    final token = await UserSecureStorage.getToken();

    final uri = Uri.parse(_url + endpoint);
    final response =
        await http.get(uri, headers: {"Authorization": "Token " + token!});
    final json = jsonDecode(utf8.decode(response.bodyBytes));
    final profile = UserProfileDetailedDto.fromJson(json);
    return profile;
  }

  Future<UserProfileDetailedDto> getMyProfile() async {
    String endpoint = '/users/self/';
    final token = await UserSecureStorage.getToken();

    final uri = Uri.parse(_url + endpoint);
    final response =
        await http.get(uri, headers: {"Authorization": "Token " + token!});
    final json = jsonDecode(utf8.decode(response.bodyBytes))["results"] as List;
    final profile = UserProfileDetailedDto.fromJson(json.first);
    return profile;
  }

  Future<int> updateAvatar(Avatar avatar) async {
    String endpoint = '/user/avatar/';
    final token = await UserSecureStorage.getToken();
    String json = jsonEncode(avatar.jsonValue);
    final uri = Uri.parse(_url + endpoint);
    final response = await http.put(uri,
        headers: {
          'Accept': 'application/json',
          "Authorization": "Token " + token!,
          'Content-Type': 'application/json'
        },
        body: json);

    return response.statusCode;
  }

  Future<int> updateEmissions(
      EmissionDto transportEmission, EmissionDto energyEmission) async {
    String endpoint = '/emissions/update/';
    final token = await UserSecureStorage.getToken();
    Map<String, dynamic> data = {
      "weekNo": transportEmission.weekNo,
      "year": transportEmission.year,
      "month": transportEmission.month,
      "emissions": [
        {"emission": transportEmission.emissions, "isTransport": true},
        {"emission": energyEmission.emissions, "isTransport": false}
      ]
    };
    String json = jsonEncode(data);
    final uri = Uri.parse(_url + endpoint);
    final response = await http.post(uri,
        headers: {
          'Accept': 'application/json',
          "Authorization": "Token " + token!,
          'Content-Type': 'application/json'
        },
        body: json);

    return response.statusCode;
  }
}
