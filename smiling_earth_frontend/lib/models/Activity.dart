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