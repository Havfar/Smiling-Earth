import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smiling_earth_frontend/config/web_config.dart';
import 'package:smiling_earth_frontend/models/pledge.dart';
import 'package:smiling_earth_frontend/utils/services/secure_storage_service.dart';

class PledgeClient {
  final _url = WebConfig.baseUrl;

  Future<List<PledgeDto>> getPledges() async {
    String endpoint = '/pledge/';
    final token = await UserSecureStorage.getToken();

    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token!});
      final json =
          jsonDecode(utf8.decode(response.bodyBytes))["results"] as List;
      final pledges = json.map((pledgeJson) {
        return PledgeDto.fromJson(pledgeJson);
      }).toList();
      return pledges;
    } catch (e) {
      throw e;
    }
  }

  Future<List<PledgeDto>> getTeamPledges(int teamId) async {
    String endpoint = '/pledge/team/' + teamId.toString();
    final token = await UserSecureStorage.getToken();

    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token!});
      final json =
          jsonDecode(utf8.decode(response.bodyBytes))["results"] as List;
      final pledges = json.map((pledgeJson) {
        return PledgeDto.fromJson(pledgeJson['pledge']);
      }).toList();
      return pledges;
    } catch (e) {
      throw e;
    }
  }

  Future<List<PledgeDto>> getUserPledges(int userId) async {
    String endpoint = '/pledge/user/' + userId.toString() + '/';
    final token = await UserSecureStorage.getToken();

    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token!});
      final json =
          jsonDecode(utf8.decode(response.bodyBytes))["results"] as List;
      final pledges = json.map((pledgeJson) {
        return PledgeDto.fromJson(pledgeJson['pledge']);
      }).toList();
      return pledges;
    } catch (e) {
      throw e;
    }
  }

  Future<List<PledgeDto>> getMyUserPledges() async {
    String endpoint = '/pledge/user/self/';
    final token = await UserSecureStorage.getToken();

    try {
      final uri = Uri.parse(_url + endpoint);
      final response =
          await http.get(uri, headers: {"Authorization": "Token " + token!});
      final json =
          jsonDecode(utf8.decode(response.bodyBytes))["results"] as List;
      final pledges = json.map((pledgeJson) {
        return PledgeDto.fromJson(pledgeJson['pledge']);
      }).toList();
      return pledges;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> createUserPledge(List<int> pledges) async {
    String endpoint = '/pledge/user/';
    final token = await UserSecureStorage.getToken();

    try {
      final uri = Uri.parse(_url + endpoint);
      var list = jsonEncode(pledges.toList());
      Map<String, dynamic> body = {"pledges": list};
      final response = await http.post(uri,
          headers: {"Authorization": "Token " + token!}, body: body);
      // body: jsonEncode(body));
      if (response.statusCode == 201) {
        return true;
      }
      throw Exception('error');
    } catch (e) {
      throw e;
    }
  }
}
