import 'package:smiling_earth_frontend/cubit/user/user_client.dart';
import 'package:smiling_earth_frontend/models/emission.dart';
import 'package:smiling_earth_frontend/utils/services/activity_db_manager.dart';
import 'package:smiling_earth_frontend/utils/services/energy_db_manager.dart';

class UpdateEmissionsUtil {
  UserClient _client = UserClient();

  Future<void> updateEmission() async {
    print('updating emissions');
    double transportEmission = await ActivityDatabaseManager.instance
        .geEmissionMonthByDate(DateTime.now());
    double energyEmission =
        await EnergyDatabaseManager.instance.getTotalHeatLoad();
    var transportEmissionDto =
        new EmissionDto(0, transportEmission, true, 2021, 11, 47);

    var energyEmissionDto =
        new EmissionDto(0, energyEmission, false, 2021, 11, 47);
    await _client.updateEmissions(transportEmissionDto, energyEmissionDto);
    print('Emission updating completed');
  }
}
