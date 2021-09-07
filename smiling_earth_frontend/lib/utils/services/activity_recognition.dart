import 'dart:io';

import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smiling_earth_frontend/models/Activity.dart';
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
  print("Start tracking");
  activityStream = activityRecognition.startStream(runForegroundService: true);
  await activityStream.listen(_onData);
}

void _onData(ActivityEvent activityEvent) async {
  print("onData");
  print(activityEvent.toString());
  if (activityEvent.type != latestActivity.type) {
    await DatabaseHelper.instance.add(Activity(
        title: activityEvent.type.toString(),
        type: activityEvent.type.index,
        timestamp: activityEvent.timeStamp.millisecondsSinceEpoch));
  }
}
