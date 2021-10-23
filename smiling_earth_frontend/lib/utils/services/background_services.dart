import 'package:smiling_earth_frontend/models/activity.dart';
import 'package:smiling_earth_frontend/utils/services/energy_db_manager.dart';
import 'package:workmanager/workmanager.dart';

const backgroundTask = "simplePeriodicTask";

const List<double> temp = [
  0,
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23
];

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    print("Native called background task: $backgroundTask");
    EnergyDatabaseManager.instance.add(new EnergyActivity(
      title: "Energy",
      date: DateTime.now(),
      heatLoad: 1.86,
      heatLoadForecast: 1.86,
    ));
    return Future.value(true);
  });
}

void callbackDispatcherTest() {
  print("Native called background task: $backgroundTask");
  EnergyDatabaseManager.instance.add(new EnergyActivity(
    title: "Energy",
    date: DateTime.now(),
    heatLoad: 1.86,
    heatLoadForecast: 1.86,
  ));
  return;
}

Future initializeWorkManagerAndPushNotification() async {
  print('starting background service');

  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  ); //to true if still in testing lev turn it to false whenever you are launching the app
  Workmanager().registerPeriodicTask(
    "1", backgroundTask,
    frequency: Duration(minutes: 15), //when should it check the link
    initialDelay:
        Duration(seconds: 30), //duration before showing the notification
    // constraints: Constraints(
    //   networkType: NetworkType.connected,
    // ),
  );
}
