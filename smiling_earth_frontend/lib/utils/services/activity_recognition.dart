import 'dart:io';

import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smiling_earth_frontend/models/activity.dart';
import 'package:smiling_earth_frontend/utils/services/database.dart';

ActivityEvent latestActivity = ActivityEvent.empty();
ActivityRecognition activityRecognition = ActivityRecognition.instance;
late Stream<ActivityEvent> activityStream;

Future<void> startActivityMonitor() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Start the activity stream updates
  if (Platform.isAndroid) {
    if (await Permission.activityRecognition.request().isGranted) {
      _startTracking();
    }
  }

  /// iOS does not
  else {
    _startTracking();
  }
}

void _startTracking() async {
  activityStream = activityRecognition.startStream(runForegroundService: true);
  await activityStream.listen(_onData);
}

void _onData(ActivityEvent activityEvent) async {
  //TODO: Må slik at starttime blir

  if (activityEvent.type != latestActivity.type) {
    if (![
      ActivityType.INVALID.index,
      ActivityType.STILL.index,
      ActivityType.TILTING.index,
      ActivityType.UNKNOWN.index,
    ].contains(activityEvent.type.index)) {
      await DatabaseHelper.instance.add(Activity(
          title: generateTitle(activityEvent),
          type: activityEvent.type.index,
          startDate: activityEvent.timeStamp,
          endDate: activityEvent.timeStamp));
    }
    latestActivity = activityEvent;
  }
}

String generateTitle(ActivityEvent event) {
  return getTimeName(event.timeStamp) +
      " " +
      getActivityNameByActivityType(event.type);
}

String getTimeName(DateTime time) {
  int hour = time.hour;

  if (hour > 6 && hour < 12) {
    return "Morning";
  } else if (hour >= 12 && hour < 18) {
    return "Day";
  } else if (hour >= 18 && hour < 22) {
    return "Evening";
  } else {
    return 'Night';
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
    case ActivityType.INVALID:
      return 'Invalid';
    case ActivityType.UNKNOWN:
      return 'UNKOWN';
    case ActivityType.STILL:
      return 'Still';
    case ActivityType.TILTING:
      return 'tilt';
    default:
      return "Other";
  }
}
