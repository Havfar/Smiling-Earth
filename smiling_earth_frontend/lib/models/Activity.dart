import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Activity {
  final int? id;
  final String title;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? tag;
  final int type;

  Activity(
      {this.id,
      required this.title,
      required this.startDate,
      required this.endDate,
      required this.type,
      this.tag});

  static DateTime calculateEndTime(DateTime datetime, int hour, int minutes) {
    Duration duration = Duration(hours: hour, minutes: minutes);
    return datetime.add(duration);
  }

  static int getDurationMinutes(Activity activity) {
    return activity.endDate!.difference(activity.startDate!).inMinutes % 60;
  }

  static int getDurationHours(Activity activity) {
    return activity.endDate!.difference(activity.startDate!).inHours;
  }

  static String formatDatetime(DateTime? time) {
    return DateFormat('h:mm').format(time!);
  }

  static String formatActivityForListTile(Activity activity) {
    int hours = getDurationHours(activity);
    int minutes = getDurationMinutes(activity);

    String startTime = activity.startDate!.hour.toString() +
        ":" +
        activity.startDate!.minute.toString();

    String duration = hours == 0
        ? minutes.toString() + "min"
        : hours.toString() + "hours " + minutes.toString() + "min";

    return "at " + startTime + " for " + duration;
  }

  static String getDateWithDayOfWeek(Activity activity) {
    return DateFormat('EEEE, d MMM, yyyy').format(activity.startDate!);
  }

  factory Activity.fromMap(Map<String, dynamic> json) => new Activity(
      id: json['id'],
      title: json['title'],
      startDate: DateTime.tryParse(json['start_date']),
      endDate: DateTime.tryParse(json['end_date']),
      type: json['type'],
      tag: json['tag']);

  ActivityDto toDto() {
    return ActivityDto(
        title: this.title,
        description: '',
        activityEnumValue: this.type,
        startTime: this.startDate!.toIso8601String(),
        endTime: endDate!.toIso8601String());
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'start_date': startDate!.toIso8601String(),
      'end_date': endDate!.toIso8601String(),
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
    return this.endDate!.difference(this.startDate!).inMinutes;
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
  final String? startTime;
  final String? endTime;
  final int? tag;
  final int activityEnumValue;

  ActivityDto(
      {this.id,
      this.user,
      required this.title,
      this.description,
      this.startTime,
      this.endTime,
      this.tag,
      required this.activityEnumValue});

  Map<String, dynamic> toJson() => {
        "title": this.title,
        "description": this.description,
        "start_time": this.startTime,
        "end_time": this.endTime,
        // "tag": this.tag,
        "activity_enum_value": this.activityEnumValue.toString()
      };

  factory ActivityDto.fromJson(Map<String, dynamic> json) => new ActivityDto(
      id: json['id'],
      user: json["user"],
      title: json["title"],
      description: json["description"],
      // start_time: json["start_time"],
      // end_time: json["end_time"],
      tag: json["tag"],
      activityEnumValue: json["activity_enum_value"]);
}
