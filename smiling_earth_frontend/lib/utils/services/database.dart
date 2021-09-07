import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smiling_earth_frontend/models/Activity.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'history.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    print("creating db");
    await db.execute('''
      CREATE TABLE activities(
          id INTEGER PRIMARY KEY,
          title TEXT,
          timestamp INTEGER,
          type INTEGER
      )
      ''');
  }

  Future<List<Activity>> getActivities() async {
    print("getting Activities");
    Database db = await instance.database;
    var activities = await db.query('activities', orderBy: 'id');
    List<Activity> activitiesList = activities.isNotEmpty
        ? activities.map((c) => Activity.fromMap(c)).toList()
        : [];
    return activitiesList;
  }

  Future<int> add(Activity activity) async {
    Database db = await instance.database;
    return await db.insert('activities', activity.toMap());
  }

  Future<int> insertActivity(Activity activity) async {
    Database db = await instance.database;
    return await db.insert('activities', activity.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('activites', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Activity activity) async {
    Database db = await instance.database;
    return await db.update('activites', activity.toMap(),
        where: "id = ?", whereArgs: [activity.id]);
  }
}
