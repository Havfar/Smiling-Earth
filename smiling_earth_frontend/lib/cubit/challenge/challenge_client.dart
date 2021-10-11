import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smiling_earth_frontend/config/web_config.dart';
import 'package:smiling_earth_frontend/models/challenge.dart';

class ChallengesClient {
  final _url = WebConfig.baseUrl;
  final token = "1ef4424ee40e7f213893ffe0c1da4cff1d8b5797";

  Future<List<ChallengeDto>> getChallenges() async {
    String endpoint = '/challenges/';
    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token});
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

  Future<DetailedChallengeDto> getChallengeDetailed(int challengeId) async {
    String endpoint = '/challenges/' + challengeId.toString() + '/';
    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token});
      final json = jsonDecode(utf8.decode(response.bodyBytes));
      print(response.body);
      return DetailedChallengeDto.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  Future<List<JoinedChallengeDto>> getJoinedChallenges() async {
    String endpoint = '/challenges/user/';
    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token});
      final json =
          jsonDecode(utf8.decode(response.bodyBytes))["results"] as List;
      print(json);

      final challenges = json.map((challengeJson) {
        return JoinedChallengeDto.fromJson(challengeJson);
      }).toList();
      return challenges;
    } catch (e) {
      throw e;
    }
  }
}
