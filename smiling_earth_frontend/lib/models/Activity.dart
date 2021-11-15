import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smiling_earth_frontend/models/calories.dart';
import 'package:smiling_earth_frontend/models/energy.dart';
import 'package:smiling_earth_frontend/models/transportation.dart';
import 'package:smiling_earth_frontend/models/vehicle_cost.dart';
import 'package:smiling_earth_frontend/utils/activity_util.dart';

abstract class ActivityInterface {
  final int? id;
  final String title;
  final DateTime? startDate;

  ActivityInterface(this.id, this.title, this.startDate);

  double getEmission() {
    return 0.0;
  }
}

class Activity extends ActivityInterface {
  final int? id;
  final String title;
  final DateTime? startDate;
  DateTime? endDate;
  final String? tag;
  final int type;

  Activity({
    this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.type,
    this.tag,
  }) : super(id, title, startDate);

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
    return DateFormat('hh:mm').format(time!);
  }

  static String formatDuration(Activity activity) {
    int hours = Activity.getDurationHours(activity);
    int minutes = Activity.getDurationMinutes(activity);
    String output = 'Duration: ';
    if (hours > 0) {
      output += '$hours h ';
    }
    output += '$minutes min';
    return output;
  }

  @override
  double getEmission() {
    var activity = AppActivityType.values[this.type];
    var duration = startDate!.difference(endDate!).abs();
    switch (activity) {
      case AppActivityType.IN_CAR:
        return Transportation.getGasolineCarEmission(duration);
      // return Energy.calculatePastHourElectricityCo2(this.temperature!);
      case AppActivityType.IN_BUS:
        return Transportation.getBusEmission(duration);
      case AppActivityType.IN_PLANE:
        return Transportation.getFlyingEmission(duration);

      default:
        return 0;
    }
  }

  double getCalories() {
    var activity = AppActivityType.values[this.type];
    var duration = startDate!.difference(endDate!).abs();
    switch (activity) {
      case AppActivityType.WALKING:
        return Calories(null, null, null)
            .calculateCaloriesFromWalkingDuration(duration.inMinutes);
      case AppActivityType.RUNNING:
        return Calories(null, null, null)
            .calculateCaloriesFromRunningDuration(duration.inMinutes);
      case AppActivityType.ON_FOOT:
        return Calories(null, null, null)
            .calculateCaloriesFromWalkingDuration(duration.inMinutes);
      case AppActivityType.ON_BICYCLE:
        return Calories(null, null, null)
            .calculateCaloriesFromCyclingDuration(duration.inMinutes);
      default:
        return 0;
    }
  }

  double getMoneySaved() {
    var activity = AppActivityType.values[this.type];
    var duration = startDate!.difference(endDate!).abs();
    switch (activity) {
      case AppActivityType.WALKING:
        return (Calories.calculateWalkingDistance(duration.inMinutes) *
            VehicleCost.defaultVehicle().avgCostPrKm);
      case AppActivityType.ON_FOOT:
        return (Calories.calculateWalkingDistance(duration.inMinutes) *
            VehicleCost.defaultVehicle().avgCostPrKm);
      case AppActivityType.RUNNING:
        return (Calories.calculateRunningDistance(duration.inMinutes) *
            VehicleCost.defaultVehicle().avgCostPrKm);
      case AppActivityType.ON_BICYCLE:
        return (Calories.calculateCyclingDistance(duration.inMinutes) *
            VehicleCost.defaultVehicle().avgCostPrKm);
      default:
        return 0;
    }
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
        tag: json['tag'],
      );

  ActivityDto toDto() {
    return ActivityDto(
      title: this.title,
      description: '',
      activityEnumValue: this.type,
      startTime: this.startDate!.toIso8601String(),
      endTime: endDate!.toIso8601String(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'start_date': startDate!.toIso8601String(),
      'end_date': endDate!.toIso8601String(),
      'tag': null,
      'type': type,
    };
  }

  IconData getIcon() {
    if (this.type == -1) {
      return Icons.power;
    }
    var activityType = AppActivityType.values[this.type];
    // var activityType = AppActivityType.values[activity.type];
    switch (activityType) {
      case AppActivityType.ELECTRICITY:
        return Icons.power;
      case AppActivityType.IN_VEHICLE:
        return Icons.commute;
      case AppActivityType.WALKING:
        return Icons.directions_walk;
      case AppActivityType.RUNNING:
        return Icons.directions_run_outlined;
      case AppActivityType.ON_BICYCLE:
        return Icons.directions_bike_outlined;
      case AppActivityType.ON_FOOT:
        return Icons.directions_walk;
      case AppActivityType.IN_CAR:
        return Icons.directions_car;
      case AppActivityType.IN_BUS:
        return Icons.directions_bus_filled_rounded;
      case AppActivityType.IN_TRAIN:
        return Icons.train;
      case AppActivityType.ON_ELECTRIC_SCOOTER:
        return Icons.electric_scooter;
      case AppActivityType.IN_PLANE:
        return Icons.airplanemode_active;
      case AppActivityType.IN_FERRY:
        return Icons.directions_ferry;
      case AppActivityType.IN_ELECTRIC_CAR:
        return Icons.electric_car;
      default:
        return Icons.error;
    }
  }

  int getTotalDurationInMinutes() {
    return this.startDate!.difference(this.endDate!).inMinutes.abs();
  }

  int getTotalDurationInSeconds() {
    return this.startDate!.difference(this.endDate!).inSeconds.abs();
  }
}

class ActivityGroupedByDate {
  final DateTime date;
  final List<ActivityInterface> activities;
  final double emissions;

  ActivityGroupedByDate(
      {required this.date, required this.activities, required this.emissions});
}

class ActivityDto {
  final int? id;
  final String? user;
  final String title;
  final String? description;
  final String startTime;
  final String endTime;
  final int? tag;
  final int activityEnumValue;

  ActivityDto(
      {this.id,
      this.user,
      required this.title,
      this.description,
      required this.startTime,
      required this.endTime,
      this.tag,
      required this.activityEnumValue});

  Map<String, dynamic> toJson() => {
        "title": this.title,
        "description": this.description,
        "start_time": this.startTime,
        "end_time": this.endTime,
        "activity_enum_value": this.activityEnumValue.toString()
      };

  factory ActivityDto.fromJson(Map<String, dynamic> json) {
    return new ActivityDto(
        id: json['id'],
        user: json["user"],
        title: json["title"],
        description: json["description"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        tag: json["tag"],
        activityEnumValue: json["activity_enum_value"]);
  }

  Activity toActivtiy() {
    return new Activity(
        title: this.title,
        startDate: DateTime.tryParse(startTime),
        endDate: DateTime.tryParse(endTime),
        type: activityEnumValue);
  }
}

class EnergyActivity extends ActivityInterface {
  final int? id;
  final String title;
  final double heatLoad;
  final double heatLoadForecast;

  final DateTime? date;

  EnergyActivity(
      {required this.title,
      required this.date,
      required this.heatLoad,
      required this.heatLoadForecast,
      this.id})
      : super(id, title, date);

  factory EnergyActivity.fromMap(Map<String, dynamic> json) =>
      new EnergyActivity(
          id: json['id'],
          title: 'Energy',
          date: DateTime.tryParse(json['date']),
          heatLoad: json['heat_load'],
          heatLoadForecast: json['heat_load_forecast']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date!.toIso8601String(),
      'heat_load': heatLoad,
      'heat_load_forecast': heatLoadForecast
    };
  }

  @override
  double getEmission() {
    return Energy.calculateCO2FromElectricity(heatLoad);
  }
}
