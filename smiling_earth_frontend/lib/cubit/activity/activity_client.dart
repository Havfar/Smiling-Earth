import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smiling_earth_frontend/config/web_config.dart';
import 'package:smiling_earth_frontend/models/activity.dart';

class ActivityClient {
  final _url = WebConfig.baseUrl;
  final token = "1ef4424ee40e7f213893ffe0c1da4cff1d8b5797";

  Future<ActivityDto> newActivity(ActivityDto activityDto) async {
    String endpoint = '/activities/';
    try {
      final uri = Uri.parse(_url + endpoint);
      final response = await http.post(uri,
          headers: {"Authorization": "Token " + token},
          body: activityDto.toJson());

      final json = jsonDecode(response.body);
      print(response.body);

      return ActivityDto.fromJson(json);
    } catch (e) {
      throw e;
    }
  }
}
