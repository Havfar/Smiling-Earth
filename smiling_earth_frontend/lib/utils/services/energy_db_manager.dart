import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smiling_earth_frontend/models/activity.dart';
import 'package:sqflite/sqflite.dart';

class EnergyDatabaseManager {
  EnergyDatabaseManager._privateConstructor();
  static final EnergyDatabaseManager instance =
      EnergyDatabaseManager._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'energy.db');
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
      CREATE TABLE energy(
          id INTEGER PRIMARY KEY,
          date TEXT,
          heat_load REAL,
          heat_load_forecast REAL
      )
      ''');
  }

  Future<List<EnergyActivity>> getHeat() async {
    Database db = await instance.database;
    var activitiesQuery = await db.query('energy', orderBy: 'id', limit: 1000);

    List<EnergyActivity> activites = [];
    for (var activityJson in activitiesQuery) {
      EnergyActivity activity = EnergyActivity.fromMap(activityJson);
      activites.add(activity);
    }
    return activites;
  }

  Future<double> getHeatByDatetime(DateTime time) async {
    Database db = await instance.database;
    var activitiesQuery = await db.query('energy',
        orderBy: 'id', where: 'date LIKE ?', whereArgs: ['2021-10%']);

    // whereArgs: [time.toIso8601String().split('T').first + '%']);
    double emissions = 0.0;
    for (var activityJson in activitiesQuery) {
      EnergyActivity activity = EnergyActivity.fromMap(activityJson);
      emissions += activity.getEmission();
    }
    return emissions;
  }

  Future<double> getHeatMonthByDatetime(DateTime time) async {
    Database db = await instance.database;
    var activitiesQuery = await db.query('energy',
        orderBy: 'id',
        where: 'date LIKE ?',
        whereArgs: [
          time.toIso8601String().split('T').first.substring(0, 7) + '%'
        ]);
    double emissions = 0.0;
    for (var activityJson in activitiesQuery) {
      EnergyActivity activity = EnergyActivity.fromMap(activityJson);
      emissions += activity.getEmission();
    }
    return emissions;
  }

  Future<double> getAverageDailyConsumption() async {
    Database db = await instance.database;
    var activitiesQuery = await db.query(
      'energy',
      orderBy: 'id',
    );
    double heatLoad = 0.0;
    int days = 0;
    DateTime previousDay = DateTime(0);
    for (var activityJson in activitiesQuery) {
      EnergyActivity activity = EnergyActivity.fromMap(activityJson);
      heatLoad += activity.heatLoad;
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
    return heatLoad / days;
  }

  Future<int> add(EnergyActivity activity) async {
    print("Adding activity " + activity.title);
    Database db = await instance.database;
    return await db.insert('energy', activity.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('energy', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(EnergyActivity activity) async {
    Database db = await instance.database;
    return await db.update('energy', activity.toMap(),
        where: "id = ?", whereArgs: [activity.id]);
  }
}
