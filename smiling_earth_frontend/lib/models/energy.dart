// These models and their values are copied from the previous version of Smiling Earth by Ragnhild Larsen and Celine Mihn. The code has been transefered and updated from Java code to flutter code.

class Energy {
  static double heatingConstant = 0.0165;
  static double co2Factor = 0.137;
  static double electricityPrice = 0.95;
  static double irradiance = 0.6;
  static double pvOutput = 0.516;
  static double energyTariff = 0.44;

  static double calculateElectricityCost() {
    double electricityCost = 0;
    for (var hour = 0; hour < 24; hour++) {
      electricityCost += Heat.getCurrentHeat(hour) * electricityPrice;
    }
    return electricityCost;
  }

  static double calculateElectricityCo2() {
    double electricityCost = 0;
    for (var hour = 0; hour < 24; hour++) {
      electricityCost += Heat.getCurrentHeatingCO2(hour);
    }
    return electricityCost;
  }

  static double calculatePastHourElectricityCo2(double temperature) {
    double electricityCost =
        Heat.getHeatingCO2ByOutsideTemperature(temperature);
    return electricityCost;
  }

  static double calculateElectricityCostWithSolar(double pvSystemSize) {
    double electricityCost = 0;
    for (var hour = 0; hour < 24; hour++) {
      electricityCost += (Heat.getCurrentHeat(hour) - pvOutput * pvSystemSize) *
          electricityPrice;
    }
    return electricityCost;
  }

  static double getPVOutput() {
    return irradiance * 0.86; // factor 0.86 to poorly approximate
  }
}

class Heat {
  static double roomTemperature = 22.0;
  static double outsideTemperature = 10.0;
  static double heatingConstant = 0.015;
  static double pvOutput1kw = 3;
  static double defaultElectricityLoad = 0.4;

  static double getCurrentHeat(int hour) {
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
    return getCurrentHeat(0) * Energy.electricityPrice;
  }

  static double getCurrentHeatingCO2(int hour) {
    return getCurrentHeat(hour) * Energy.co2Factor;
  }

  static double getCurrentHeatingCO2PerDay() {
    return getCurrentHeat(0) * Energy.co2Factor * 24;
  }
}

class Expenses {
  //TODO: make it accurate
  static double solarPanelPrice = 100000;

  double calculateSavings(int type) {
    double savings = 0;
    switch (type) {
      case 1:
        //Solar
        savings = Energy.calculateElectricityCost() -
            Energy.calculateElectricityCostWithSolar(1);
        break;
      case 2:
        //walking
        savings = Energy.calculateElectricityCost() -
            Energy.calculateElectricityCostWithSolar(1);
        break;
      case 3:
        //cycling
        savings = Energy.calculateElectricityCost() -
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

class Transportation {}
