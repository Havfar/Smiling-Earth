import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:flutter/material.dart';

class Activity {
  final int? id;
  final String title;
  final int start_timestamp;
  final int end_timestamp;
  final int type;

  Activity(
      {this.id,
      required this.title,
      required this.start_timestamp,
      required this.end_timestamp,
      required this.type});

  factory Activity.fromMap(Map<String, dynamic> json) => new Activity(
      id: json['id'],
      title: json['title'],
      start_timestamp: json['start_timestamp'],
      end_timestamp: json['end_timestamp'],
      type: json['type']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'start_timestamp': start_timestamp,
      'end_timestamp': end_timestamp,
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
