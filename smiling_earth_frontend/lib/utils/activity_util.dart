import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/models/activity.dart';

String getActivityNameByActivity(Activity activity) {
  var activityType = AppActivityType.values[activity.type];
  return getActivityNameByActivityType(activityType);
}

String getActivityNameByActivityType(AppActivityType type) {
  switch (type) {
    case AppActivityType.IN_VEHICLE:
      return "Drive";
    case AppActivityType.IN_CAR:
      return "Drive";
    case AppActivityType.IN_ELECTRIC_CAR:
      return "Drive";
    case AppActivityType.IN_BUS:
      return "Ride";
    case AppActivityType.RUNNING:
      return "Run";
    case AppActivityType.ON_BICYCLE:
      return "Ride";
    case AppActivityType.ON_FOOT:
      return "Walk";
    case AppActivityType.WALKING:
      return "Walk";
    default:
      return "Other";
  }
}

String getTransporationNameByActivityType(AppActivityType type) {
  switch (type) {
    case AppActivityType.IN_CAR:
      return "Car";
    case AppActivityType.IN_BUS:
      return "Bus";
    case AppActivityType.ON_BICYCLE:
      return "Bicycle";
    case AppActivityType.IN_ELECTRIC_CAR:
      return "Electric car";
    case AppActivityType.IN_PLANE:
      return "AirPlane";
    case AppActivityType.IN_TRAIN:
      return "Train";
    case AppActivityType.ON_ELECTRIC_SCOOTER:
      return "Electric Scooter";
    case AppActivityType.ON_FOOT:
      return "Walk";
    case AppActivityType.WALKING:
      return "Walk";
    case AppActivityType.RUNNING:
      return "Run";
    default:
      return "Other";
  }
}

IconData getTransporationIconByActivityType(AppActivityType type) {
  switch (type) {
    case AppActivityType.IN_CAR:
      return Icons.directions_car;
    case AppActivityType.IN_BUS:
      return Icons.directions_bus;

    case AppActivityType.ON_BICYCLE:
      return Icons.directions_bike;

    case AppActivityType.IN_ELECTRIC_CAR:
      return Icons.electric_car;

    case AppActivityType.IN_PLANE:
      return Icons.flight;

    case AppActivityType.IN_TRAIN:
      return Icons.directions_railway;

    case AppActivityType.ON_ELECTRIC_SCOOTER:
      return Icons.electric_scooter;

    default:
      return Icons.error;
  }
}

IconData getIconByActivity(Activity activity) {
  var activityType = AppActivityType.values[activity.type];
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

IconData getIconByActivityType(AppActivityType activityType) {
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

enum AppActivityType {
  ELECTRICITY,
  IN_VEHICLE,
  ON_BICYCLE,
  ON_FOOT,
  RUNNING,
  WALKING,
  // INVALID, // Used for parsing errors
  IN_CAR,
  IN_ELECTRIC_CAR,
  IN_BUS,
  IN_TRAIN,
  IN_TRAM,
  ON_ELECTRIC_SCOOTER,
  IN_PLANE,
  IN_FERRY,
}

List<AppActivityType> getTransportationTypes() {
  return [
    AppActivityType.WALKING,
    AppActivityType.RUNNING,
    AppActivityType.ON_BICYCLE,
    AppActivityType.IN_CAR,
    AppActivityType.ON_ELECTRIC_SCOOTER,
    AppActivityType.IN_ELECTRIC_CAR,
    AppActivityType.IN_BUS,
    // AppActivityType.IN_PLANE,
    AppActivityType.IN_TRAIN,
  ];
}

enum TransporationType {
  ON_BICYCLE,
  RUNNING,
  WALKING,
  IN_CAR,
  IN_ELECTRIC_CAR,
  IN_BUS,
  IN_TRAIN,
  ON_ELECTRIC_SCOOTER,
  IN_PLANE,
}
