import 'package:http/http.dart' as http;
import 'package:smiling_earth_frontend/config/web_config.dart';
import 'package:smiling_earth_frontend/models/activity.dart';
import 'package:smiling_earth_frontend/utils/services/secure_storage_service.dart';

class ActivityClient {
  final _url = WebConfig.baseUrl;

  Future<bool> newActivity(ActivityDto activityDto) async {
    final token = await UserSecureStorage.getToken();

    String endpoint = '/activities/';
    try {
      final uri = Uri.parse(_url + endpoint);
      final response = await http.post(uri,
          headers: {"Authorization": "Token " + token!},
          body: activityDto.toJson());

      return response.statusCode == 201;
    } catch (e) {
      throw e;
    }
  }
}
