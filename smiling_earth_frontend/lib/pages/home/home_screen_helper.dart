import 'package:smiling_earth_frontend/utils/services/activity_db_manager.dart';
import 'package:smiling_earth_frontend/utils/services/energy_db_manager.dart';

class ChartData {
  final double energy;
  final double transport;

  ChartData(this.energy, this.transport);

  double getTotal() {
    return (energy + transport).roundToDouble();
  }
}

Future<ChartData> getChartDataByMonth(DateTime date) async {
  double energy =
      await EnergyDatabaseManager.instance.getHeatMonthByDatetime(date);
  double transport =
      await ActivityDatabaseManager.instance.geEmissionMonthByDate(date);
  var data = ChartData(energy, transport);
  return data;
}
