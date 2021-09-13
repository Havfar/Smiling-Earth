import 'dart:io';

import 'package:collection/collection.dart';
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
          start_date TEXT,
          start_time TEXT,
          end_date TEXT,
          end_time TEXT,
          type INTEGER,
          tag TEXT
      )
      ''');
  }

  Future<List<ActivityGroupedByDate>> getActivities() async {
    Database db = await instance.database;
    var activitiesQuery = await db.query('activities', orderBy: 'id');
    // var activityGroupQuery =
    //     await db.query('activities', groupBy: 'start_date');
    // List<ActivityGroupedByDate> activityGroups = activityGroupQuery.isNotEmpty
    //     ? activityGroupQuery
    //         .map((group) => ActivityGroupedByDate.fromMap(group))
    //         .toList()
    //     : [];

    //   activityGroupQuery.isNotEmpty
    // ? activityGroupQuery.map((group) => ( activityGroups.add(new ActivityGroupedByDate(date: "123",activities: getActivities("123"))))
    // : [];

    List<Activity> activitiesList = activitiesQuery.isNotEmpty
        ? activitiesQuery.map((c) => Activity.fromMap(c)).toList()
        : [];

    var groupedBy = groupBy(activitiesList, (Activity obj) => obj.start_date);
    List<ActivityGroupedByDate> activitesGroups =
        _parseActivtityGroup(groupedBy);
    return activitesGroups;
  }

  List<ActivityGroupedByDate> _parseActivtityGroup(
      Map<String, List<Activity>> groupedBy) {
    List<ActivityGroupedByDate> activity = [];
    for (var key in groupedBy.keys) {
      activity.add(new ActivityGroupedByDate(
          date: key, activities: groupedBy[key]!.toList()));
    }
    // ignore: deprecated_member_use
    return activity;
  }

  Future<List<Activity>> getActivitiesByDate(String date) async {
    Database db = await instance.database;
    var activitiesQuery = await db.query('activities',
        orderBy: 'id', where: 'start_date=' + date);

    List<Activity> activitiesList = activitiesQuery.isNotEmpty
        ? activitiesQuery.map((c) => Activity.fromMap(c)).toList()
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
    return await db.delete('activities', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Activity activity) async {
    Database db = await instance.database;
    return await db.update('activities', activity.toMap(),
        where: "id = ?", whereArgs: [activity.id]);
  }
}
