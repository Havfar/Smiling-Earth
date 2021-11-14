import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smiling_earth_frontend/config/web_config.dart';
import 'package:smiling_earth_frontend/models/rivals.dart';
import 'package:smiling_earth_frontend/models/teams.dart';
import 'package:smiling_earth_frontend/utils/services/secure_storage_service.dart';

class TeamsClient {
  final _url = WebConfig.baseUrl;

  Future<List<TeamsDto>> getJoinedTeams() async {
    String endpoint = '/teams/joined';
    final token = await UserSecureStorage.getToken();

    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token!});
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
    final token = await UserSecureStorage.getToken();

    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token!});
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
    final token = await UserSecureStorage.getToken();

    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token!});
      final json = jsonDecode(utf8.decode(response.bodyBytes));
      final team = TeamDetailedDto.fromJson(json);
      return team;
    } catch (e) {
      throw e;
    }
  }

  Future<List<double>> getTeamEmission(int id) async {
    String endpoint = '/teams/' + id.toString() + '/emissions/';
    final token = await UserSecureStorage.getToken();

    final uri = Uri.parse(_url + endpoint);
    final response =
        await http.get(uri, headers: {"Authorization": "Token " + token!});
    final json = jsonDecode(utf8.decode(response.bodyBytes));
    List<double> emissions = [json['transport'], json['energy']];
    return emissions;
  }

  Future<List<TeamMemberDto>> getTeamMembers(int id) async {
    String endpoint = '/teams/$id/members/';
    final token = await UserSecureStorage.getToken();

    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token!});
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

  Future<List<TeamsDto>> getMemberOf(int userId) async {
    final token = await UserSecureStorage.getToken();

    String endpoint = '/teams/users/' + userId.toString() + '/';
    final uri = Uri.parse(_url + endpoint);
    final response =
        await http.get(uri, headers: {"Authorization": "Token " + token!});
    final json = jsonDecode(utf8.decode(response.bodyBytes))["results"] as List;
    final teams = json.map((team) => TeamsDto.fromJson(team['team'])).toList();
    return teams;
  }

  Future<int> joinTeam(int id) async {
    String endpoint = '/join_team/';
    final token = await UserSecureStorage.getToken();

    try {
      final uri = Uri.parse(_url + endpoint);

      final response = await http.post(uri,
          headers: {"Authorization": "Token " + token!},
          body: {'team': id.toString()});
      return response.statusCode;
    } catch (e) {
      throw e;
    }
  }

  Future<List<TeamsDto>> getRivals(int teamId) async {
    String endpoint = '/rivals/$teamId/';
    final token = await UserSecureStorage.getToken();

    final uri = Uri.parse(_url + endpoint);
    final response =
        await http.get(uri, headers: {"Authorization": "Token " + token!});
    final json = jsonDecode(utf8.decode(response.bodyBytes))['results'] as List;
    final rivals = json.map((rival) {
      var rivalry = RivalDto.fromJson(rival);
      if (rivalry.sender.id == teamId) {
        return rivalry.receiver;
      }
      return rivalry.sender;
    }).toList();
    return rivals;
  }

  Future<List<TeamsDto>> getOtherTeams(int teamId) async {
    String endpoint = '/rivals/$teamId/other/';
    final token = await UserSecureStorage.getToken();

    final uri = Uri.parse(_url + endpoint);
    final response =
        await http.get(uri, headers: {"Authorization": "Token " + token!});
    final json = jsonDecode(utf8.decode(response.bodyBytes))['results'] as List;
    final teams = json.map((team) => TeamsDto.fromJson(team)).toList();
    return teams;
  }

  Future<void> leaveTeam(int teamId) async {
    String endpoint = '/teams/$teamId/leave/';
    final token = await UserSecureStorage.getToken();

    final uri = Uri.parse(_url + endpoint);
    final response =
        await http.delete(uri, headers: {"Authorization": "Token " + token!});
  }

  Future<List<RivalDto>> getRivalRequests(int teamId) async {
    String endpoint = '/rival_requests/$teamId/';
    final token = await UserSecureStorage.getToken();

    final uri = Uri.parse(_url + endpoint);
    final response =
        await http.get(uri, headers: {"Authorization": "Token " + token!});
    final json = jsonDecode(utf8.decode(response.bodyBytes))['results'] as List;
    final rivals = json.map((rival) {
      return RivalDto.fromJson(rival);
    }).toList();
    return rivals;
  }

  Future<int> sendRivalryRequest(SimpleRivalDto rivalry) async {
    String endpoint = '/rival_requests/new/';
    final token = await UserSecureStorage.getToken();

    final uri = Uri.parse(_url + endpoint);
    final response = await http.post(uri,
        headers: {
          'Accept': 'application/json',
          "Authorization": "Token " + token!,
          'Content-Type': 'application/json'
        },
        body: jsonEncode(rivalry.toMap()));
    return response.statusCode;
  }

  Future<int> updateRivalryRequest(RivalDto rivalry) async {
    String endpoint = '/rival_requests/${rivalry.id}/update/';
    final token = await UserSecureStorage.getToken();

    final uri = Uri.parse(_url + endpoint);
    final response = await http.put(uri,
        headers: {
          'Accept': 'application/json',
          "Authorization": "Token " + token!,
          'Content-Type': 'application/json'
        },
        body: jsonEncode(rivalry.toMap()));
    return response.statusCode;
  }

  Future<int> deleteRivalryRequest(RivalDto rivalry) async {
    String endpoint = '/rival_requests/${rivalry.id}/update/';
    final token = await UserSecureStorage.getToken();

    final uri = Uri.parse(_url + endpoint);
    final response =
        await http.delete(uri, headers: {"Authorization": "Token " + token!});
    return response.statusCode;
  }
}
