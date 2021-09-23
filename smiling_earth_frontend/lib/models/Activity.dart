import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:flutter/material.dart';

class Activity {
  final int? id;
  final String title;
  final String start_date;
  final String start_time;
  final String end_date;
  final String end_time;
  final String? tag;
  final int type;

  Activity(
      {this.id,
      required this.title,
      required this.start_date,
      required this.start_time,
      required this.end_date,
      required this.end_time,
      required this.type,
      this.tag});

  factory Activity.fromMap(Map<String, dynamic> json) => new Activity(
      id: json['id'],
      title: json['title'],
      start_date: json['start_date'],
      start_time: json['start_time'],
      end_date: json['end_date'],
      end_time: json['end_time'],
      type: json['type'],
      tag: json['tag']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'start_date': start_date,
      'start_time': start_time,
      'end_date': end_date,
      'end_time': end_time,
      'tag': tag,
      'type': type
    };
  }

  IconData getIcon() {
    var activity = ActivityType.values[this.type];
    switch (activity) {
      case ActivityType.IN_VEHICLE:
        return Icons.directions_car;
      case ActivityType.WALKING:
        return Icons.directions_walk;
      case ActivityType.RUNNING:
        return Icons.directions_run_outlined;
      case ActivityType.ON_BICYCLE:
        return Icons.directions_bike_outlined;
      case ActivityType.ON_FOOT:
        return Icons.directions_walk;
      default:
        return Icons.error;
    }
  }
}

class ActivityGroupedByDate {
  final String date;
  final List<Activity> activities;

  ActivityGroupedByDate({required this.date, required this.activities});
}
// activities: DatabaseHelper.instance.getActivitiesByDate(json['start_date'])

// "activity": "{'id': 7, 'user': 'hv.farestveit@gmail.com', 'title': '123', 'description': '123', 'start_time': '2021-08-11T15:32:00Z', 'end_time': '2021-08-03T15:32:00Z', 'tag': 1, 'activity_enum_value': 1}"

class ActivityDto {
  final int? id;
  final String? user;
  final String title;
  final String description;
  final String start_time;
  final String end_time;
  final int? tag;
  final int activity_enum_value;

  ActivityDto(
      {this.id,
      this.user,
      required this.title,
      required this.description,
      required this.start_time,
      required this.end_time,
      this.tag,
      required this.activity_enum_value});

  Map<String, dynamic> toJson() => {
        "title": this.title,
        "description": this.description,
        "start_time": this.start_time,
        "end_time": this.end_time,
        "tag": this.tag,
        "activity_enum_value": this.activity_enum_value
      };

  factory ActivityDto.fromJson(Map<String, dynamic> json) => new ActivityDto(
      id: json['id'],
      user: json["user"],
      title: json["title"],
      description: json["description"],
      start_time: json["start_time"],
      end_time: json["end_time"],
      tag: json["tag"],
      activity_enum_value: json["activity_enum_value"]);
}
