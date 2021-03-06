import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Settings {
  final int? id;
  final String? preferredTransport;
  final String? building_year;
  final String? last_renocation_year;
  final String? heating_type;
  final String? car_reg_no;
  final int? car_value;
  final int? car_yearly_drive;
  final int? car_planned_ownership;
  final String? first_name;
  final String? last_name;
  final String? age;
  final String? weight;
  final int? profile_picture_index;

  Settings(
      this.id,
      this.preferredTransport,
      this.building_year,
      this.last_renocation_year,
      this.heating_type,
      this.car_reg_no,
      this.car_value,
      this.car_yearly_drive,
      this.car_planned_ownership,
      this.first_name,
      this.last_name,
      this.age,
      this.weight,
      this.profile_picture_index);

  factory Settings.fromMap(Map<String, dynamic> json) {
    return new Settings(
        json['id'],
        json['preferred_transport'],
        json['building_year'],
        json['last_renocation_year'],
        json['heating_type'],
        json['car_reg_no'],
        json['car_value'],
        json['car_yearly_drive'],
        json['car_planned_ownership'],
        json['first_name'],
        json['last_name'],
        json['age'],
        json['weight'],
        json['profile_picture_index']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'preferred_transport': this.preferredTransport,
      'building_year': this.building_year,
      'last_renocation_year': this.last_renocation_year,
      'heating_type': this.heating_type,
      'car_reg_no': this.car_reg_no,
      'car_value': this.car_value,
      'car_yearly_drive': this.car_yearly_drive,
      'car_planned_ownership': this.car_planned_ownership,
      'first_name': this.first_name,
      'last_name': this.last_name,
      'age': this.age,
      'weight': this.weight,
      'profile_picture_index': this.profile_picture_index
    };
  }
}

class SettingsDatabaseManager {
  SettingsDatabaseManager._privateConstructor();
  static final SettingsDatabaseManager instance =
      SettingsDatabaseManager._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'settings.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  Future _onCreate(Database db, int version) async {
    print("creating settings table");
    await db.execute('''
      CREATE TABLE settings(
          id INTEGER PRIMARY KEY,
          preferred_transport TEXT,
          building_year TEXT,
          last_renocation_year TEXT,
          heating_type TEXT,
          car_reg_no TEXT,
          car_value INTEGER,
          car_yearly_drive INTEGER,
          car_planned_ownership INTEGER,
          first_name TEXT,
          last_name TEXT,
          age TEXT,
          weight TEXT,
          profile_picture_index INTEGER
      )
      ''');
    // await add(Settings(null, null, null, null, null, null, null, null, null,
    //     null, null, null, null, null));
  }

  Future<bool> hasRegistered() async {
    Database db = await instance.database;
    var result = await db.rawQuery(
      'SELECT EXISTS(SELECT 1 FROM settings WHERE id=0)',
    );
    int? exists = Sqflite.firstIntValue(result);
    return exists == 1;
  }

  Future<Settings> get() async {
    Database db = await instance.database;
    List<Map<String, Object?>> settingsQuery =
        await db.query('settings', where: 'id = 0');
    Map<String, dynamic> json = settingsQuery.first;

    Settings settings = Settings.fromMap(settingsQuery.first);
    return settings;
  }

  Future<String> getName() async {
    Database db = await instance.database;
    List<Map<String, Object?>> settingsQuery = await db.query('settings',
        columns: ['first_name', 'last_name'], where: 'id = 0');
    Map<String, dynamic> json = settingsQuery.first;
    return json['first_name'] + ' ' + json['last_name'];
  }

  Future<int> add(Settings settings) async {
    print('inserte new settings id: ${settings.id}');
    Database db = await instance.database;
    await db.delete('settings', where: 'id=0');
    return await db.insert('settings', settings.toMap());
  }

  Future<int> reset(Settings settings) async {
    print('clearing settings');
    Database db = await instance.database;
    return await db.update('settings', settings.toMap(), where: "id = 0");
  }

  Future<int> delete() async {
    print('delete settings');
    Database db = await instance.database;
    return await db.delete('settings', where: "id = 0");
  }

  Future<int> update(Settings newSettings) async {
    print('updating ');
    Database db = await instance.database;
    var oldSettings = await get();

    Settings settings = _compareOldAndNewSettings(oldSettings, newSettings);
    return await db.update('settings', settings.toMap(), where: "id = 0");
  }

  Settings _compareOldAndNewSettings(
      Settings oldSettings, Settings newSettings) {
    int? _id = 0;
    String? _preferredTransport = newSettings.preferredTransport == null
        ? oldSettings.preferredTransport
        : newSettings.preferredTransport;
    String? _building_year = newSettings.building_year == null
        ? oldSettings.building_year
        : newSettings.building_year;
    String? _last_renocation_year = newSettings.last_renocation_year == null
        ? oldSettings.last_renocation_year
        : newSettings.last_renocation_year;
    String? _heating_type = newSettings.heating_type == null
        ? oldSettings.heating_type
        : newSettings.heating_type;
    String? _car_reg_no = newSettings.car_reg_no == null
        ? oldSettings.car_reg_no
        : newSettings.car_reg_no;
    int? _car_value = newSettings.car_value == null
        ? oldSettings.car_value
        : newSettings.car_value;
    int? _car_yearly_drive = newSettings.car_yearly_drive == null
        ? oldSettings.car_yearly_drive
        : newSettings.car_yearly_drive;
    int? _car_planned_ownership = newSettings.car_planned_ownership == null
        ? oldSettings.car_planned_ownership
        : newSettings.car_planned_ownership;
    String? _first_name = newSettings.first_name == null
        ? oldSettings.first_name
        : newSettings.first_name;
    String? _last_name = newSettings.last_name == null
        ? oldSettings.last_name
        : newSettings.last_name;
    String? _age = newSettings.age == null ? oldSettings.age : newSettings.age;
    String? _weight =
        newSettings.weight == null ? oldSettings.weight : newSettings.weight;
    int? _profile_picture_index = newSettings.profile_picture_index == null
        ? oldSettings.profile_picture_index
        : newSettings.profile_picture_index;

    return Settings(
        _id,
        _preferredTransport,
        _building_year,
        _last_renocation_year,
        _heating_type,
        _car_reg_no,
        _car_value,
        _car_yearly_drive,
        _car_planned_ownership,
        _first_name,
        _last_name,
        _age,
        _weight,
        _profile_picture_index);
  }
}
