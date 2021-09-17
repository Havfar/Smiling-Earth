import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smiling_earth_frontend/bloc/login/model/ApiUserLogin.dart';

// final _base = "https://home-hub-app.herokuapp.com";
// final _base = "http://127.0.0.1:8000";
final _base = "https://smiling-earth-backend.herokuapp.com";

final _tokenEndpoint = "/api-token-auth/";
final _tokenURL = _base + _tokenEndpoint;

Future<Token> getToken(UserLogin userLogin) async {
  print(_tokenURL);
  var x = Uri.parse(_tokenURL);
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
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}
