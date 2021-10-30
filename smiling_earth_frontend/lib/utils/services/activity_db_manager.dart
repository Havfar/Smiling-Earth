import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smiling_earth_frontend/models/activity.dart';
import 'package:smiling_earth_frontend/models/transportation.dart';
import 'package:smiling_earth_frontend/utils/activity_util.dart';
import 'package:sqflite/sqflite.dart';

class ActivityDatabaseManager {
  ActivityDatabaseManager._privateConstructor();
  static final ActivityDatabaseManager instance =
      ActivityDatabaseManager._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'history.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  // UPGRADE DATABASE TABLES
  // todo: Fiks https://efthymis.com/migrating-a-mobile-database-in-flutter-sqlite/
  // void _onUpgrade(Database db, int oldVersion, int newVersion) {
  //   if (oldVersion < newVersion) {
  //     db.execute("ALTER TABLE history ADD COLUMN e;");
  //   }
  // }

  Future _onCreate(Database db, int version) async {
    print("creating db");
    await db.execute('''
      CREATE TABLE activities(
          id INTEGER PRIMARY KEY,
          title TEXT,
          start_date TEXT,
          end_date TEXT,
          type INTEGER,
          tag TEXT,
          temperature REAL
      )
      ''');
  }

  Future<List<Activity>> getActivities() async {
    Database db = await instance.database;
    var activitiesQuery =
        await db.query('activities', orderBy: 'id', limit: 1000);

    List<Activity> activitiesList = [];

    if (activitiesQuery.isNotEmpty) {
      late Activity newActivity;

      bool isInitized = false;
      for (var activityJson in activitiesQuery) {
        // print(activityJson);

        Activity nextActivity = Activity.fromMap(activityJson);

        if (!isInitized) {
          newActivity = nextActivity;
          isInitized = true;
        } else {
          if (nextActivity.type == newActivity.type) {
            Duration difference =
                nextActivity.startDate!.difference(newActivity.endDate!);
            if (difference.inMinutes > 5) {
              activitiesList.add(newActivity);
              newActivity = nextActivity;
            } else {
              newActivity.endDate = nextActivity.startDate;
            }
          } else {
            activitiesList.add(newActivity);
            newActivity = nextActivity;
          }
        }
      }
      activitiesList.add(newActivity);
    }

    return activitiesList;
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

  Future<double> geEmissionByDate(DateTime date) async {
    Database db = await instance.database;
    var activitiesQuery = await db.query('activities',
        orderBy: 'id',
        where: 'start_date LIKE ?',
        whereArgs: [date.toIso8601String().split('T').first + '%']);

    double emissions = 0;
    for (var activity in activitiesQuery) {
      print(activity);

      emissions += Activity.fromMap(activity).getEmission();
    }

    return emissions;
  }

  Future<double> getDurationDrivingPerDay() async {
    Database db = await instance.database;
    var activitiesQuery = await db.query(
      'activities',
      orderBy: 'id',
      where: 'type=' + AppActivityType.IN_CAR.index.toString(),
    );

    double emissions = 0;
    double distance = 0;
    int days = 0;
    DateTime previousDay = DateTime(0);
    for (var activityQ in activitiesQuery) {
      var activity = Activity.fromMap(activityQ);
      emissions += activity.getEmission();

      distance += Transportation.convertCarDurationToDistance(
          activity.getTotalDurationInMinutes());
      if (previousDay.year == 0) {
        previousDay = activity.startDate!;
        days += 1;
      }
      if (previousDay.day != activity.startDate!.day) {
        days += 1;
        previousDay = activity.startDate!;
      }
    }
    if (days == 0) {
      return 0;
    }
    return distance / days;
  }

  Future<double> geEmissionMonthByDate(DateTime date) async {
    Database db = await instance.database;
    var activitiesQuery = await db.query('activities',
        orderBy: 'id',
        where: 'start_date LIKE ?',
        whereArgs: [
          date.toIso8601String().split('T').first.substring(0, 7) + '%'
        ]);

    double emissions = 0;
    for (var activity in activitiesQuery) {
      emissions += Activity.fromMap(activity).getEmission();
    }
    return emissions;
  }

  Future<int> add(Activity activity) async {
    print("Adding activity " + activity.title);
    Database db = await instance.database;
    return await db.insert('activities', activity.toMap());
  }

  Future<int> insertActivity(Activity activity) async {
    print("Adding activity " + activity.title);

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
