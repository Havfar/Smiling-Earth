import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smiling_earth_frontend/config/web_config.dart';
import 'package:smiling_earth_frontend/models/activity.dart';
import 'package:smiling_earth_frontend/utils/services/secure_storage_service.dart';

class ActivityClient {
  final _url = WebConfig.baseUrl;

  Future<ActivityDto> newActivity(ActivityDto activityDto) async {
    final token = await UserSecureStorage.getToken();

    String endpoint = '/activities/';
    try {
      final uri = Uri.parse(_url + endpoint);
      final response = await http.post(uri,
          headers: {"Authorization": "Token " + token!},
          body: activityDto.toJson());

      final json = jsonDecode(response.body);

      return ActivityDto.fromJson(json);
    } catch (e) {
      throw e;
    }
  }
}
