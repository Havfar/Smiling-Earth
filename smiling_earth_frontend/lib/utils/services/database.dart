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
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    // add(new Activity(
    //     title: "Test1",
    //     start_timestamp: 1631083067,
    //     end_timestamp: 1631083167,
    //     type: ActivityType.IN_VEHICLE.index));

    // add(new Activity(
    //     title: "Test2",
    //     start_timestamp: 1631083167,
    //     end_timestamp: 1631083267,
    //     type: ActivityType.ON_BICYCLE.index));

    // add(new Activity(
    //     title: "Test3",
    //     start_timestamp: 1631083267,
    //     end_timestamp: 1631083367,
    //     type: ActivityType.ON_FOOT.index));
    return db;
  }

  // UPGRADE DATABASE TABLES
  // TODO: Fiks https://efthymis.com/migrating-a-mobile-database-in-flutter-sqlite/
  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      db.execute("ALTER TABLE history ADD COLUMN e;");
    }
  }

  Future _onCreate(Database db, int version) async {
    print("creating db");
    await db.execute('''
      CREATE TABLE activities(
          id INTEGER PRIMARY KEY,
          title TEXT,
          start_timestamp INTEGER,
          end_timestamp INTEGER,
          type INTEGER
      )
      ''');
  }

  Future<List<Activity>> getActivities() async {
    Database db = await instance.database;
    var activities = await db.query('activities', orderBy: 'id');
    List<Activity> activitiesList = activities.isNotEmpty
        ? activities.map((c) => Activity.fromMap(c)).toList()
        : [];
    return activitiesList;
  }

  // Future<List<Activity>> getActivitiesGroupedByDate async{
  //   return new List<Activity>;
  // }

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
    return await db.delete('activities', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Activity activity) async {
    Database db = await instance.database;
    return await db.update('activities', activity.toMap(),
        where: "id = ?", whereArgs: [activity.id]);
  }
}
