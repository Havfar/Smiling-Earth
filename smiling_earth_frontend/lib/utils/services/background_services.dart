import 'package:smiling_earth_frontend/models/activity.dart';
import 'package:smiling_earth_frontend/models/energy.dart';
import 'package:smiling_earth_frontend/utils/challenges_util.dart';
import 'package:smiling_earth_frontend/utils/services/energy_db_manager.dart';
import 'package:smiling_earth_frontend/utils/services/local_notifications_service.dart';
import 'package:smiling_earth_frontend/utils/update_emissions_util.dart';
import 'package:workmanager/workmanager.dart';

const fetchEnergyUsageTask = "fetchEnergy";
const updateEmissionTask = "updateEmissionEnergy";
const updateChallengeProgressTask = "updateChallengeProgress";
const fetchNotificationsTask = "fetchNotifications";
const sendLocalUpdate = "localUpdate";
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
      case sendLocalUpdate:
        print("Native called background task: $sendLocalUpdate");
        await NotificationService().showNotifications();
        return Future.value(true);

      default:
        return Future.value(true);
    }
  });
}

initializeWorkManagerAndPushNotification() {
  print('starting background service');

  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false,
  );
  Workmanager().registerPeriodicTask(
    "1", fetchEnergyUsageTask,
    frequency: Duration(hours: 1), //when should it check the link
    initialDelay: Duration(minutes: 10),
  );

  Workmanager().registerPeriodicTask(
    "2",
    updateEmissionTask,
    frequency: Duration(hours: 6),
    initialDelay: Duration(hours: 1),
  );

  Workmanager().registerPeriodicTask(
    "3", updateChallengeProgressTask,
    frequency: Duration(hours: 4), //when should it check the link
    initialDelay: Duration(minutes: 90),
  );

  Workmanager().registerPeriodicTask(
    "4", sendLocalUpdate,
    frequency: Duration(days: 1), //when should it check the link
    initialDelay: Duration(hours: 2),
  );
}
