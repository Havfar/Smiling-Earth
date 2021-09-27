import 'dart:io';

import 'package:collection/collection.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smiling_earth_frontend/models/activity.dart';
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
          end_date TEXT,
          type INTEGER,
          tag TEXT
      )
      ''');
  }

  Future<List<ActivityGroupedByDate>> getActivities() async {
    Database db = await instance.database;
    var activitiesQuery = await db.query('activities', orderBy: 'id');

    List<Activity> activitiesList = activitiesQuery.isNotEmpty
        ? activitiesQuery.map((c) => Activity.fromMap(c)).toList()
        : [];

    var groupedBy = groupBy(activitiesList,
        (Activity obj) => obj.start_date!.toString().substring(0, 10));
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
