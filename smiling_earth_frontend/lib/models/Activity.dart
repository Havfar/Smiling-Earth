import 'package:flutter/material.dart';

class Activity {
  final int? id;
  final String title;
  final int timestamp;
  final int type;

  Activity(
      {this.id,
      required this.title,
      required this.timestamp,
      required this.type});

  factory Activity.fromMap(Map<String, dynamic> json) => new Activity(
      id: json['id'],
      title: json['title'],
      timestamp: json['timestamp'],
      type: json['type']);

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'timestamp': timestamp, 'type': type};
  }

  IconData getIcon() {
    print(this.type);
    switch (this.type) {
      case 0:
        return Icons.directions_walk;
      case 1:
        return Icons.directions_bike;
      case 2:
        return Icons.directions_walk_outlined;
      case 3:
        return Icons.directions_bike_outlined;
      case 4:
        return Icons.directions_run_outlined;
      case 5:
        return Icons.directions_walk;
      default:
        return Icons.directions_run;
    }
  }
}
