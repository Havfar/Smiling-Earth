import 'dart:io';

import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smiling_earth_frontend/models/activity.dart';
import 'package:smiling_earth_frontend/utils/activity_util.dart';
import 'package:smiling_earth_frontend/utils/services/activity_db_manager.dart';

ActivityEvent previousActivity = ActivityEvent.empty();
ActivityRecognition activityRecognition = ActivityRecognition.instance;
late Stream<ActivityEvent> activityStream;
DateTime timer = DateTime.now();

Future<void> startActivityMonitor() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("start tracking");

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

void _startTracking() {
  activityStream = activityRecognition.startStream(runForegroundService: true);
  activityStream.listen(_onData);
}

void _onData(ActivityEvent activityEvent) async {
  // print(activityEvent.type);

  if (previousActivity.type != activityEvent.type) {
    print("Activity changed");
    if (activityEvent.timeStamp.difference(timer).inMinutes > 2) {
      print('over two minutes');
      if (![
        ActivityType.INVALID.index,
        ActivityType.STILL.index,
        ActivityType.TILTING.index,
        ActivityType.UNKNOWN.index,
      ].contains(previousActivity.type.index)) {
        // if(latestActivity.timeStamp.)

        await ActivityDatabaseManager.instance.add(Activity(
            title: generateTitle(previousActivity),
            type: convertToAppActivity(previousActivity.type).index,
            startDate: previousActivity.timeStamp,
            endDate: activityEvent.timeStamp));
      }
      previousActivity = activityEvent;
    }
  } else {
    if (![
      ActivityType.INVALID.index,
      ActivityType.STILL.index,
      ActivityType.TILTING.index,
      ActivityType.UNKNOWN.index,
    ].contains(previousActivity.type.index)) {
      // Reset timer
      print('Timer Reset');
      timer = DateTime.now();
    }
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
      return "Bicycle ride";
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

AppActivityType convertToAppActivity(ActivityType type) {
  switch (type) {
    case ActivityType.IN_VEHICLE:
      return AppActivityType.IN_CAR;
    case ActivityType.WALKING:
      return AppActivityType.WALKING;
    case ActivityType.RUNNING:
      return AppActivityType.RUNNING;
    case ActivityType.ON_BICYCLE:
      return AppActivityType.ON_BICYCLE;
    case ActivityType.ON_FOOT:
      return AppActivityType.WALKING;
    default:
      return AppActivityType.WALKING;
  }
}
