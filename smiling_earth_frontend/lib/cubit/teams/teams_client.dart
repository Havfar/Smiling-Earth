import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smiling_earth_frontend/config/web_config.dart';
import 'package:smiling_earth_frontend/models/rivals.dart';
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
      final json =
          jsonDecode(utf8.decode(response.bodyBytes))["results"] as List;
      final teams = json.map((teamJson) {
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
      final json =
          jsonDecode(utf8.decode(response.bodyBytes))["results"] as List;
      final teams = json.map((teamJson) {
        return TeamsDto.fromJson(teamJson);
      }).toList();
      return teams;
    } catch (e) {
      throw e;
    }
  }

  Future<TeamDetailedDto> getTeam(int id) async {
    String endpoint = '/teams/' + id.toString() + "/";
    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token});
      final json = jsonDecode(utf8.decode(response.bodyBytes));
      final team = TeamDetailedDto.fromJson(json);
      return team;
    } catch (e) {
      throw e;
    }
  }

  // Future<List<TeamEmissionDto>> getTeamEmission(int id) async {
  //   String endpoint = '/teams/' + id.toString() + '/emissions/';
  //   try {
  //     final uri = Uri.parse(_url + endpoint);
  //     final response =
  //         await http.get(uri, headers: {"Authorization": "Token " + token});
  //     final json =
  //         jsonDecode(utf8.decode(response.bodyBytes))["results"] as List;
  //     print(json);
  //     final emissions = json
  //         .map((teamEmission) => TeamEmissionDto.fromJson(teamEmission))
  //         .toList();
  //     print(emissions.toString());
  //     return emissions;
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  Future<List<TeamMemberDto>> getTeamMembers(int id) async {
    String endpoint = '/teams/' + id.toString() + '/members/';
    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token});
      final json =
          jsonDecode(utf8.decode(response.bodyBytes))["results"] as List;
      final emissions = json
          .map((teamEmission) => TeamMemberDto.fromJson(teamEmission))
          .toList();

      // return emissions.sort((a, b) => return b.emissions.compareTo(a.emissions));
      return emissions;
    } catch (e) {
      throw e;
    }
  }

  Future<int> joinTeam(int id) async {
    String endpoint = '/join_team/';
    try {
      final uri = Uri.parse(_url + endpoint);

      final response = await http.post(uri,
          headers: {"Authorization": "Token " + token},
          body: {'team': id.toString()});
      // final json = jsonDecode(utf8.decode(response.bodyBytes));
      return response.statusCode;
    } catch (e) {
      throw e;
    }
  }

  Future<List<RivalDto>> getRivals(int teamId) async {
    String endpoint = '/rivals/' + teamId.toString();
    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token});
      final json =
          jsonDecode(utf8.decode(response.bodyBytes))['results'] as List;
      final rivals = json.map((rival) => RivalDto.fromJson(rival)).toList();
      return rivals;
    } catch (e) {
      throw e;
    }
  }
}
