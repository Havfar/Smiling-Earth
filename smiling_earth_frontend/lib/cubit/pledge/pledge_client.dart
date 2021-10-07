import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smiling_earth_frontend/config/web_config.dart';
import 'package:smiling_earth_frontend/models/pledge.dart';

class PledgeClient {
  final _url = WebConfig.baseUrl;
  final token = "1ef4424ee40e7f213893ffe0c1da4cff1d8b5797";

  // Future<List<PledgeDto>> getPledges{
  //   throw Error();
  // }

  // Future<List<PledgeDto>> getPledges{
  //   throw Error();
  // }
  Future<List<PledgeDto>> getPledges() async {
    String endpoint = '/pledge/';
    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token});
      final json = jsonDecode(response.body)["results"] as List;
      final pledges = json.map((pledgeJson) {
        return PledgeDto.fromJson(pledgeJson['pledge']);
      }).toList();
      return pledges;
    } catch (e) {
      throw e;
    }
  }

  Future<List<PledgeDto>> getTeamPledges(int teamId) async {
    String endpoint = '/pledge/team/' + teamId.toString();
    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token});
      final json =
          jsonDecode(utf8.decode(response.bodyBytes))["results"] as List;
      var pledge = json.first['pledge'];
      final pledges = json.map((pledgeJson) {
        return PledgeDto.fromJson(pledgeJson['pledge']);
      }).toList();
      return pledges;
    } catch (e) {
      throw e;
    }
  }

  Future<List<PledgeDto>> getUserPledges(int userId) async {
    String endpoint = '/pledge/user/' + userId.toString();
    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token});
      final json = jsonDecode(response.body)["results"] as List;
      final pledges = json.map((pledgeJson) {
        return PledgeDto.fromJson(pledgeJson['pledge']);
      }).toList();
      return pledges;
    } catch (e) {
      throw e;
    }
  }
}
