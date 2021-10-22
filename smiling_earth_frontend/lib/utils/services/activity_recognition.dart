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
  print(activityEvent.type);

  // if (activityEvent.type != latestActivity.type) {

  // if (![
  //   ActivityType.INVALID.index,
  //   ActivityType.STILL.index,
  //   ActivityType.TILTING.index,
  //   ActivityType.UNKNOWN.index,
  // ].contains(activityEvent.type.index)) {
  //   if (latestActivity.type == ActivityType.UNKNOWN ||
  //       latestActivity.type == ActivityType.STILL) {
  //     print("ein. " +
  //         latestActivity.type.toString() +
  //         " " +
  //         activityEvent.type.toString());
  //     await DatabaseHelper.instance.add(Activity(
  //         title: generateTitle(activityEvent),
  //         type: activityEvent.type.index,
  //         startDate: activityEvent.timeStamp,
  //         endDate: activityEvent.timeStamp));
  //     latestActivity = activityEvent;
  //   } else {
  //     print("to. " +
  //         latestActivity.type.toString() +
  //         " " +
  //         activityEvent.type.toString());

  //     if (latestActivity.type != activityEvent.type) {
  //       print("tre");

  //       await DatabaseHelper.instance.add(Activity(
  //           title: generateTitle(latestActivity),
  //           type: latestActivity.type.index,
  //           startDate: latestActivity.timeStamp,
  //           endDate: activityEvent.timeStamp));

  //       latestActivity = activityEvent;
  //     }
  //   }
  // }

  // if (activityEvent.type == ActivityType.STILL) {
  //   if (latestActivity.type == ActivityType.ON_FOOT) {
  //     print("fira");
  //     await DatabaseHelper.instance.add(Activity(
  //         title: generateTitle(latestActivity),
  //         type: latestActivity.type.index,
  //         startDate: latestActivity.timeStamp,
  //         endDate: activityEvent.timeStamp));
  //   } else if (latestActivity.type == ActivityType.ON_BICYCLE) {
  //     print("fem");
  //     await DatabaseHelper.instance.add(Activity(
  //         title: generateTitle(latestActivity),
  //         type: latestActivity.type.index,
  //         startDate: latestActivity.timeStamp,
  //         endDate: activityEvent.timeStamp));
  //   }
  //   latestActivity = activityEvent;
  // }

  if (latestActivity.type != activityEvent.type) {
    print("Activity changed");
    if (![
      ActivityType.INVALID.index,
      ActivityType.STILL.index,
      ActivityType.TILTING.index,
      ActivityType.UNKNOWN.index,
    ].contains(latestActivity.type.index)) {
      Duration dur =
          latestActivity.timeStamp.difference(activityEvent.timeStamp);
      print("Save Transistion from:" +
          latestActivity.type.toString() +
          " to " +
          activityEvent.toString() +
          ". Duration: " +
          dur.inSeconds.toString() +
          " seconds");
      await DatabaseHelper.instance.add(Activity(
          title: "new: " + generateTitle(latestActivity),
          type: latestActivity.type.index,
          startDate: latestActivity.timeStamp,
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
