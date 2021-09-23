import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/models/activity.dart';

String getActivityNameByActivity(Activity activity) {
  var activityType = ActivityType.values[activity.type];
  switch (activityType) {
    case ActivityType.IN_VEHICLE:
      return "Drive";
    case ActivityType.WALKING:
      return "Walk";
    case ActivityType.RUNNING:
      return "Run";
    case ActivityType.ON_BICYCLE:
      return "Bicycle";
    case ActivityType.ON_FOOT:
      return "Walk";
    default:
      return "Other";
  }
}

String getActivityNameByActivityType(ActivityType type) {
  switch (type) {
    case ActivityType.IN_VEHICLE:
      return "Drive";
    case ActivityType.WALKING:
      return "Walk";
    case ActivityType.RUNNING:
      return "Run";
    case ActivityType.ON_BICYCLE:
      return "Bicycle";
    case ActivityType.ON_FOOT:
      return "Walk";
    default:
      return "Other";
  }
}

IconData getIconByActivity(Activity activity) {
  var activityType = ActivityType.values[activity.type];
  switch (activityType) {
    case ActivityType.IN_VEHICLE:
      return Icons.commute;
    case ActivityType.WALKING:
      return Icons.directions_walk;
    case ActivityType.RUNNING:
      return Icons.directions_run_outlined;
    case ActivityType.ON_BICYCLE:
      return Icons.directions_bike_outlined;
    case ActivityType.ON_FOOT:
      return Icons.directions_walk;
    case ActivityType.IN_CAR:
      return Icons.directions_car;
    case ActivityType.IN_BUS:
      return Icons.directions_bus_filled_rounded;
    case ActivityType.IN_TRAIN:
      return Icons.train;
    case ActivityType.ON_ELECTRIC_SCOOTER:
      return Icons.electric_scooter;
    case ActivityType.IN_PLANE:
      return Icons.airplanemode_active;
    case ActivityType.IN_FERRY:
      return Icons.directions_ferry;
    case ActivityType.IN_ELECTRIC_CAR:
      return Icons.electric_car;
    default:
      return Icons.error;
  }
}

IconData getIconByActivityType(ActivityType activityType) {
  switch (activityType) {
    case ActivityType.IN_VEHICLE:
      return Icons.commute;
    case ActivityType.WALKING:
      return Icons.directions_walk;
    case ActivityType.RUNNING:
      return Icons.directions_run_outlined;
    case ActivityType.ON_BICYCLE:
      return Icons.directions_bike_outlined;
    case ActivityType.ON_FOOT:
      return Icons.directions_walk;
    case ActivityType.IN_CAR:
      return Icons.directions_car;
    case ActivityType.IN_BUS:
      return Icons.directions_bus_filled_rounded;
    case ActivityType.IN_TRAIN:
      return Icons.train;
    case ActivityType.ON_ELECTRIC_SCOOTER:
      return Icons.electric_scooter;
    case ActivityType.IN_PLANE:
      return Icons.airplanemode_active;
    case ActivityType.IN_FERRY:
      return Icons.directions_ferry;
    case ActivityType.IN_ELECTRIC_CAR:
      return Icons.electric_car;
    default:
      return Icons.error;
  }
}

enum ActivityType {
  IN_VEHICLE,
  ON_BICYCLE,
  ON_FOOT,
  RUNNING,
  STILL,
  TILTING,
  UNKNOWN,
  WALKING,
  INVALID, // Used for parsing errors
  IN_CAR,
  IN_ELECTRIC_CAR,
  IN_BUS,
  IN_TRAIN,
  IN_TRAM,
  ON_ELECTRIC_SCOOTER,
  IN_PLANE,
  IN_FERRY,
}
