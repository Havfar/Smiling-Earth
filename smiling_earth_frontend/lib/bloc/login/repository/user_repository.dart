import 'dart:async';

import 'package:smiling_earth_frontend/bloc/login/api_connection/api_connection.dart';
import 'package:smiling_earth_frontend/bloc/login/dao/UserDao.dart';
import 'package:smiling_earth_frontend/bloc/login/model/ApiUserLogin.dart';
import 'package:smiling_earth_frontend/models/user.dart';
import 'package:smiling_earth_frontend/utils/services/secure_storage_service.dart';

class UserRepository {
  final userDao = UserDao();

  Future<User> authenticate({
    required String username,
    required String password,
  }) async {
    UserLogin userLogin = UserLogin(username: username, password: password);
    Token token = await getToken(userLogin);
    User user = User(
      id: 0,
      username: username,
      token: token.token,
    );
    return user;
  }

  Future<void> persistToken({required User user}) async {
    // write token with the user to the database
    await userDao.createUser(user);
    await UserSecureStorage.setToken(user.token);
  }

  Future<void> deleteToken({required int id}) async {
    await userDao.deleteUser(id);
    await UserSecureStorage.setToken('');
  }

  Future<bool> hasToken() async {
    bool result = await userDao.checkUser(0);
    return result;
  }
}
