// These models and their values are copied from the previous version of Smiling Earth by Ragnhild Larsen and Celine Mihn. The code has been transefered and updated from Java code to flutter code.

import 'package:smiling_earth_frontend/utils/services/energy_db_manager.dart';

class Energy {
  static double heatingConstant = 0.0165;
  static double co2Factor = 0.137;
  static double electricityPrice = 0.95;
  static double irradiance = 0.6;
  static double pvOutput = 0.516;
  static double energyTariff = 0.44;
  static List<double> outsideTemperatureByHours = [
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

  static double calculateElectricityCost(double heat) {
    return heat * electricityPrice;
  }

  static double calculateElectricityCo2() {
    double electricityCost = 0;
    for (var hour = 0; hour < 24; hour++) {
      electricityCost += Heat.getCurrentHeatingCO2(hour);
    }
    return electricityCost;
  }

  static double calculateCO2FromElectricity(double heat) {
    return heat * co2Factor;
  }

  static double calculatePastHourElectricityCo2(double temperature) {
    double electricityCost =
        Heat.getHeatingCO2ByOutsideTemperature(temperature);
    return electricityCost;
  }

  static double calculateElectricityCostWithSolar(double pvSystemSize) {
    double electricityCost = 0;
    for (var hour = 0; hour < 24; hour++) {
      electricityCost += (Heat.getCurrentHeatByOutsideTemperature(
                  Energy.outsideTemperatureByHours[hour]) -
              pvOutput * pvSystemSize) *
          electricityPrice;
    }
    return electricityCost.roundToDouble();
  }

  static double getPVOutput() {
    return irradiance * 0.86; // factor 0.86 to poorly approximate
  }

  static double calculateDailyAverage(double load, int start, int stop) {
    return ((stop > 24 + start) ? load / (1 + (stop - start) / 24) : load);
  }

  //TODO: summeer daglig energy load fra db
  static double calculateEnergyConsumption() {
    double load = 0;
    // int[] indexes = indexesFromTimeScale(timeScale);

    // for(int i = indexes[0]; i<=indexes[1]; i++) {
    //     load += (db.getHeat(i) > -100) ? db.getHeat(i) : 0;
    // }
    // TODO make it a synchronous task - hourly or when user reopens the app
    // return calculateDailyAverage(load, indexes[0], indexes[1]);
    return 10;
  }

  static double calculateEnergyConsumptioWithSolar(
      double load, double panelSize) {
    // double load = 0;
    // int[] indexes = indexesFromTimeScale(timeScale);

    // for (int i=indexes[0]; i<=indexes[1]; i++)
    //     load += (db.getHeat(i) > -100) ? db.getHeat(i) - PVoutput * pvSystemSize : 0;

    // // TODO make it a synchronous task - hourly or when user reopens the app
    // return calculateDailyAverage(load, indexes[0], indexes[1]);

    return load - pvOutput * panelSize;
  }

  static Future<double> calculatePercentageSelfConsumption(
      double panelSize) async {
    double dailyConsumption =
        await EnergyDatabaseManager.instance.getAverageDailyConsumption();
    double dailyconsumptionWithSolar =
        calculateEnergyConsumptioWithSolar(dailyConsumption, panelSize);

    return (dailyConsumption - dailyconsumptionWithSolar) / dailyConsumption;
  }
}

class Heat {
  static double roomTemperature = 22.0;
  static double outsideTemperature = 10.0;
  static double heatingConstant = 0.015;
  static double pvOutput1kw = 3;
  static double defaultElectricityLoad = 0.4;

  static double getCurrentHeat(DateTime time) {
    //should fetch outside temperature of the hour
    double outsideTemp = Energy.outsideTemperatureByHours.elementAt(time.hour);
    return getCurrentHeatByOutsideTemperature(outsideTemp);
    // return (roomTemperature - temp[hour]) * heatingConstant;
  }

  static double getCurrentHeatByOutsideTemperature(double outsideTemp) {
    //should fetch outside temperature of the hour
    return (roomTemperature - outsideTemperature) * heatingConstant;
    // return (roomTemperature - temp[hour]) * heatingConstant;
  }

  static double getHeatingCO2ByOutsideTemperature(double outsideTemp) {
    //should fetch outside temperature of the hour
    return (roomTemperature - outsideTemp) * heatingConstant;
    // return (roomTemperature - temp[hour]) * heatingConstant;
  }

  static double getCurrentHeatingCost() {
    return getCurrentHeat(DateTime.now()) * Energy.electricityPrice;
  }

  static double getCurrentHeatingCO2(int hour) {
    return getCurrentHeat(DateTime.now()) * Energy.co2Factor;
  }

  static double getCurrentHeatingCO2PerDay() {
    return getCurrentHeat(DateTime.now()) * Energy.co2Factor * 24;
  }

  static double getHeatingCO2ByLoad(double heatload) {
    return heatload * Energy.co2Factor * 24;
  }
}

class Expenses {
  //todo: make it accurate
  static double solarPanelPrice = 100000;

  double calculateSavings(int type) {
    double savings = 0;
    switch (type) {
      case 1:
        //Solar
        savings = Energy.calculateElectricityCost(0) -
            Energy.calculateElectricityCostWithSolar(1);
        break;
      case 2:
        //walking
        savings = Energy.calculateElectricityCost(0) -
            Energy.calculateElectricityCostWithSolar(1);
        break;
      case 3:
        //cycling
        savings = Energy.calculateElectricityCost(0) -
            Energy.calculateElectricityCostWithSolar(1);
        break;
      default:
    }
    return savings > 0 ? savings : 0;
  }

  double calculateDaysLeftForSolarRoof() {
    double savings = calculateSavings(1);
    return savings > 0 ? solarPanelPrice / savings : -1;
  }
}
