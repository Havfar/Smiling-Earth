import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smiling_earth_frontend/config/web_config.dart';
import 'package:smiling_earth_frontend/models/challenge.dart';
import 'package:smiling_earth_frontend/utils/services/secure_storage_service.dart';

class ChallengesClient {
  final _url = WebConfig.baseUrl;

  Future<List<ChallengeDto>> getChallenges() async {
    String endpoint = '/challenges/';
    final token = await UserSecureStorage.getToken();

    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token!});
      final json =
          jsonDecode(utf8.decode(response.bodyBytes))["results"] as List;

      final challenges = json.map((challengeJson) {
        return ChallengeDto.fromJson(challengeJson);
      }).toList();
      return challenges;
    } catch (e) {
      throw e;
    }
  }

  // http://127.0.0.1:8000/challenges/user/1/completed

  Future<DetailedChallengeDto> getChallengeDetailed(int challengeId) async {
    String endpoint = '/challenges/' + challengeId.toString() + '/';
    final token = await UserSecureStorage.getToken();

    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token!});
      final json = jsonDecode(utf8.decode(response.bodyBytes));
      return DetailedChallengeDto.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  Future<List<ChallengeDto>> getCompletedChallenges(int userId) async {
    String endpoint = '/challenges/user/' + userId.toString() + '/completed';
    final token = await UserSecureStorage.getToken();

    final uri = Uri.parse(_url + endpoint);
    final response =
        await http.get(uri, headers: {"Authorization": "Token " + token!});
    final json = jsonDecode(utf8.decode(response.bodyBytes))["results"] as List;

    final challenges = json.map((challengeJson) {
      return ChallengeDto.fromJson(challengeJson);
    }).toList();
    return challenges;
  }

  Future<List<ChallengeDto>> getMyCompletedChallenges() async {
    String endpoint = '/challenges/user/self/completed';
    final token = await UserSecureStorage.getToken();

    final uri = Uri.parse(_url + endpoint);
    final response =
        await http.get(uri, headers: {"Authorization": "Token " + token!});
    final json = jsonDecode(utf8.decode(response.bodyBytes))["results"] as List;

    final challenges = json.map((challengeJson) {
      return ChallengeDto.fromJson(challengeJson);
    }).toList();
    return challenges;
  }

  Future<List<JoinedChallengeDto>> getJoinedChallenges() async {
    String endpoint = '/challenges/user/';
    final token = await UserSecureStorage.getToken();

    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token!});
      final json =
          jsonDecode(utf8.decode(response.bodyBytes))["results"] as List;

      final challenges = json.map((challengeJson) {
        return JoinedChallengeDto.fromJson(challengeJson);
      }).toList();
      return challenges;
    } catch (e) {
      throw e;
    }
  }

  Future<int> joinChallenge(int challengeId) async {
    String endpoint = '/challenges/join/';
    final token = await UserSecureStorage.getToken();

    try {
      final uri = Uri.parse(_url + endpoint);

      final response = await http.post(uri,
          headers: {"Authorization": "Token " + token!},
          body: {'challenge': challengeId.toString()});
      return response.statusCode;
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateProgress(ChallengeDto challenge, int progress) async {
    String endpoint = "/challenge/user/${challenge.id}/";
    final token = await UserSecureStorage.getToken();
    Map<String, dynamic> data = {
      "score": progress,
      "progress": progress,
    };
    String json = jsonEncode(data);
    final uri = Uri.parse(_url + endpoint);
    final response = await http.put(uri,
        headers: {
          'Accept': 'application/json',
          "Authorization": "Token " + token!,
          'Content-Type': 'application/json'
        },
        body: json);
    if (response.statusCode != 200) {
      throw Exception('Error when updating progress');
    }
  }
}
