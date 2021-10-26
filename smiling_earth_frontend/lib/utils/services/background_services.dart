import 'package:smiling_earth_frontend/models/activity.dart';
import 'package:smiling_earth_frontend/models/energy.dart';
import 'package:smiling_earth_frontend/utils/services/energy_db_manager.dart';
import 'package:workmanager/workmanager.dart';

const backgroundTask = "simplePeriodicTask";

const List<double> temp = [
  7,
  7,
  8,
  8,
  8,
  8,
  7,
  7,
  7,
  7,
  70,
  8,
  8,
  10,
  11,
  11,
  11,
  10,
  9,
  9,
  9,
  9,
  8,
  8
];

void callbackDispatcher() {
  print('dispatcher');
  Workmanager().executeTask((task, inputData) {
    print("Native called background task: $backgroundTask");
    var e = new EnergyActivity(
      title: "Energy",
      date: DateTime.now(),
      heatLoad: Heat.getCurrentHeat(temp.elementAt(DateTime.now().hour)),
      heatLoadForecast:
          Heat.getCurrentHeat(temp.elementAt(DateTime.now().hour)),
    );
    print('totoot');
    EnergyDatabaseManager.instance.add(e);
    print('background task completed');
    return Future.value(true);
  });
}

// void callbackDispatcherTest() {
//   print("Native called background task: $backgroundTask");
//   EnergyDatabaseManager.instance.add(new EnergyActivity(
//     title: "Energy",
//     date: DateTime.now(),
//     heatLoad: 1.86,
//     heatLoadForecast: 1.86,
//   ));
//   return;
// }

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
