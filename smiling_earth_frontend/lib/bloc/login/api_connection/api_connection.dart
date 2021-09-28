import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smiling_earth_frontend/bloc/login/model/ApiUserLogin.dart';
import 'package:smiling_earth_frontend/config/web_config.dart';

// final _base = "https://home-hub-app.herokuapp.com";
// final _base = "http://127.0.0.1:8000";
// final _base = "https://smiling-earth-backend.herokuapp.com";

final _tokenEndpoint = "/api-token-auth/";
final _tokenURL = WebConfig.baseUrl + _tokenEndpoint;

Future<Token> getToken(UserLogin userLogin) async {
  final http.Response response = await http.post(
    Uri.parse(_tokenURL),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toDatabaseJson()),
  );
  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else {
    throw Exception(json.decode(response.body));
  }
}
