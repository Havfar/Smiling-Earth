import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smiling_earth_frontend/config/web_config.dart';
import 'package:smiling_earth_frontend/models/notifications.dart';
import 'package:smiling_earth_frontend/utils/services/secure_storage_service.dart';

class NotificationClient {
  final _url = WebConfig.baseUrl;

  Future<List<NotificationDto>> getNotificaitons() async {
    String endpoint = '/notifications/';
    final token = await UserSecureStorage.getToken();

    final uri = Uri.parse(_url + endpoint);
    final response =
        await http.get(uri, headers: {"Authorization": "Token " + token!});
    final json = jsonDecode(utf8.decode(response.bodyBytes))["results"] as List;

    final notifications = json.map((notificationJson) {
      return NotificationDto.fromJson(notificationJson);
    }).toList();
    return notifications;
  }

  Future<int> getNewNotificaitonsCount() async {
    String endpoint = '/notifications/count/';
    final token = await UserSecureStorage.getToken();

    final uri = Uri.parse(_url + endpoint);
    final response =
        await http.get(uri, headers: {"Authorization": "Token " + token!});
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
    final json = jsonDecode(utf8.decode(response.bodyBytes));
    return json['new_notifications'];
  }

  Future<void> notificationRead(int id) async {
    String endpoint = "/notifications/$id/";
    final token = await UserSecureStorage.getToken();

    final uri = Uri.parse(_url + endpoint);
    final response =
        await http.put(uri, headers: {"Authorization": "Token " + token!});
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }
}
