import 'package:smiling_earth_frontend/models/activity.dart';
import 'package:smiling_earth_frontend/models/energy.dart';
import 'package:smiling_earth_frontend/utils/challenges_util.dart';
import 'package:smiling_earth_frontend/utils/services/energy_db_manager.dart';
import 'package:smiling_earth_frontend/utils/update_emissions_util.dart';
import 'package:workmanager/workmanager.dart';

const fetchEnergyUsageTask = "fetchEnergy";
const updateEmissionTask = "updateEmissionEnergy";
const updateChallengeProgressTask = "updateChallengeProgress";
const fetchNotificationsTask = "fetchNotifications";
UpdateEmissionsUtil emissionsUtil = UpdateEmissionsUtil();
ChallengesUtil challengesUtil = ChallengesUtil();

void callbackDispatcher() {
  print('dispatcher');
  Workmanager().executeTask((task, inputData) async {
    print("inside: $task");

    switch (task) {
      case fetchEnergyUsageTask:
        print("Native called background task: $fetchEnergyUsageTask");
        var energy = new EnergyActivity(
          title: "Energy",
          date: DateTime.now(),
          heatLoad: Heat.getCurrentHeat(DateTime.now()),
          heatLoadForecast: Heat.getCurrentHeat(DateTime.now()),
        );
        await EnergyDatabaseManager.instance.add(energy);
        print('background task completed');
        return Future.value(true);
      case updateEmissionTask:
        print("Native called background task: $updateEmissionTask");
        await emissionsUtil.updateEmission();
        return Future.value(true);
      case updateChallengeProgressTask:
        print("Native called background task: $updateChallengeProgressTask");
        await challengesUtil.updateChallenges();
        print('challenges updated');

        return Future.value(true);
      case fetchNotificationsTask:
        print("Native called background task: $fetchNotificationsTask");
        return Future.value(true);
      default:
        return Future.value(true);
    }
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

initializeWorkManagerAndPushNotification() {
  print('starting background service');

  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  ); //to true if still in testing lev turn it to false whenever you are launching the app
  Workmanager().registerPeriodicTask(
    "1", fetchEnergyUsageTask,
    frequency: Duration(minutes: 15), //when should it check the link
    initialDelay:
        Duration(seconds: 90), //duration before showing the notification
    // constraints: Constraints(
    //   networkType: NetworkType.connected,
    // ),
  );

  Workmanager().registerPeriodicTask(
    "2", updateEmissionTask,
    frequency: Duration(minutes: 15), //when should it check the link
    initialDelay:
        Duration(seconds: 60), //duration before showing the notification
    // constraints: Constraints(
    //   networkType: NetworkType.connected,
    // ),
  );

  Workmanager().registerPeriodicTask(
    "3", updateChallengeProgressTask,
    frequency: Duration(minutes: 15), //when should it check the link
    initialDelay:
        Duration(seconds: 120), //duration before showing the notification
    // constraints: Constraints(
    //   networkType: NetworkType.connected,
    // ),
  );

  Workmanager().registerPeriodicTask(
    "3", fetchNotificationsTask,
    frequency: Duration(minutes: 15), //when should it check the link
    initialDelay:
        Duration(seconds: 200), //duration before showing the notification
    // constraints: Constraints(
    //   networkType: NetworkType.connected,
    // ),
  );
}
