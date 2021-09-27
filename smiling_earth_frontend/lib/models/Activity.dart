import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Activity {
  final int? id;
  final String title;
  final DateTime? start_date;
  final DateTime? end_date;
  final String? tag;
  final int type;

  Activity(
      {this.id,
      required this.title,
      required this.start_date,
      required this.end_date,
      required this.type,
      this.tag});

  static DateTime calculateEndTime(DateTime datetime, int hour, int minutes) {
    Duration duration = Duration(hours: hour, minutes: minutes);
    return datetime.add(duration);
  }

  static int getDurationMinutes(Activity activity) {
    return activity.end_date!.difference(activity.start_date!).inMinutes % 60;
  }

  static int getDurationHours(Activity activity) {
    return activity.end_date!.difference(activity.start_date!).inHours;
  }

  static String formatDatetime(DateTime? time) {
    return DateFormat('h:mm').format(time!);
  }

  static String formatActivityForListTile(Activity activity) {
    int hours = getDurationHours(activity);
    int minutes = getDurationMinutes(activity);

    String start_time = activity.start_date!.hour.toString() +
        ":" +
        activity.start_date!.minute.toString();

    String duration = hours == 0
        ? minutes.toString() + "min"
        : hours.toString() + "hours " + minutes.toString() + "min";

    return "at " + start_time + " for " + duration;
  }

  static String getDateWithDayOfWeek(Activity activity) {
    return DateFormat('EEEE, d MMM, yyyy').format(activity.start_date!);
  }

  factory Activity.fromMap(Map<String, dynamic> json) => new Activity(
      id: json['id'],
      title: json['title'],
      start_date: DateTime.tryParse(json['start_date']),
      end_date: DateTime.tryParse(json['end_date']),
      type: json['type'],
      tag: json['tag']);

  ActivityDto toDto() {
    return ActivityDto(
        title: this.title,
        description: '',
        activity_enum_value: this.type,
        start_time: this.start_date!.toIso8601String(),
        end_time: end_date!.toIso8601String());
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'start_date': start_date!.toIso8601String(),
      'end_date': end_date!.toIso8601String(),
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

  int getTotalDurationInMinutes() {
    return this.end_date!.difference(this.start_date!).inMinutes;
  }
}

class ActivityGroupedByDate {
  final String date;
  final List<Activity> activities;

  ActivityGroupedByDate({required this.date, required this.activities});
}

class ActivityDto {
  final int? id;
  final String? user;
  final String title;
  final String? description;
  final String? start_time;
  final String? end_time;
  final int? tag;
  final int activity_enum_value;

  ActivityDto(
      {this.id,
      this.user,
      required this.title,
      this.description,
      this.start_time,
      this.end_time,
      this.tag,
      required this.activity_enum_value});

  Map<String, dynamic> toJson() => {
        "title": this.title,
        "description": this.description,
        "start_time": this.start_time,
        "end_time": this.end_time,
        // "tag": this.tag,
        "activity_enum_value": this.activity_enum_value.toString()
      };

  factory ActivityDto.fromJson(Map<String, dynamic> json) => new ActivityDto(
      id: json['id'],
      user: json["user"],
      title: json["title"],
      description: json["description"],
      // start_time: json["start_time"],
      // end_time: json["end_time"],
      tag: json["tag"],
      activity_enum_value: json["activity_enum_value"]);
}
