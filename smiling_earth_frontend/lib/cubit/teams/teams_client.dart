import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smiling_earth_frontend/config/web_config.dart';
import 'package:smiling_earth_frontend/models/teams.dart';

class TeamsClient {
  final _url = WebConfig.baseUrl;
  final token = "1ef4424ee40e7f213893ffe0c1da4cff1d8b5797";

  Future<List<TeamsDto>> getJoinedTeams() async {
    String endpoint = '/teams/joined';
    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token});
      final json = jsonDecode(response.body)["results"] as List;
      final teams = json.map((teamJson) {
        var x = teamJson;
        return TeamsDto.fromJson(teamJson);
      }).toList();
      return teams;
    } catch (e) {
      throw e;
    }
  }

  Future<List<TeamsDto>> getTeams() async {
    String endpoint = '/teams/';
    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token});
      final json = jsonDecode(response.body)["results"] as List;
      final teams = json.map((teamJson) {
        print(teamJson);
        var t = teamJson;
        return TeamsDto.fromJson(teamJson);
      }).toList();
      return teams;
    } catch (e) {
      throw e;
    }
  }
}
