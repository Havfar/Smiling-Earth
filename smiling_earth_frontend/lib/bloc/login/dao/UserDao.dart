import 'package:smiling_earth_frontend/bloc/login/database/user_database.dart';
import 'package:smiling_earth_frontend/models/User.dart';

class UserDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createUser(User user) async {
    final db = await dbProvider.database;

    var result = db.insert(userTable, user.toDatabaseJson());
    return result;
  }

  Future<int> deleteUser(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(userTable, where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future<bool> checkUser(int id) async {
    final db = await dbProvider.database;
    try {
      List<Map> users =
          await db.query(userTable, where: 'id = ?', whereArgs: [id]);
      if (users.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<User?> getUser() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> data = await db.query(userTable);
    if (data.isNotEmpty) {
      return User.fromDatabaseJson(data.first);
    }
    return null;
  }
}
