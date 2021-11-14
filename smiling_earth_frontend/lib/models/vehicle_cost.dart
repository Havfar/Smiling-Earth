import 'dart:core';

class VehicleCost {
  final int yearsOwnedCar;
  final int carSize; // 0 = small, 1 = medium, 2 = large
  final double cost;
  final bool isNewCar;
  final double distancePerYear;
  late double fuelConsumptionPerKm;

  final double interest = 0.04;
  final double roadFee = 2820;
  final double fuelCostPerLiter = 14;
  double tires = 0;
  final double taxFactor = 0.76;
  double fuelCost = 0;
  double insurance = 0;
  final double service = 0;
  final double wash = 0;
  double repair = 0;
  final double valueLossRateYr1 = 0.20;
  final double valueLossRateYr2 = 0.14;
  final double valueLossRateYr3 = 0.13;
  final double valueLossRateYr4 = 0.12;
  final double valueLossRateYr5 = 0.11;
  final double valueLossRateYr6 = 0.10;
  final List<num> washArray = [600, 300, 0];
  final List<double> valueLossRateArray = [0, 0, 0, 0, 0, 0];
  final List<double> insuranceInit = [4000, 4900, 5500];
  final List<double> serviceInit = [0, 50, 0];
  final List<double> tireInit = [610, 100, -650];
  final List<double> repInit = [4000, 4900, 5500];
  final List<double> defaultFuelConsumptionPrKm = [0.06, 0.07, 0.08];

  //Variables
  double valueLoss = 0;
  double interestLoss = 0;
  Map<String, String> defaultValueMap = new Map<String, String>();
  final bool preferenceChange = false;

  //info
  double totCost = 0;
  double totCostWithoutFuel = 0;
  double totFuelCostPrKm = 0;
  double avgCostPrKm = 0;
  double avgCostPrDay = 0;
  double marginalCostPr1Km = 0;
  double marginalCostFuel = 0;

  List<List<double>> distFactor = [
    [12, 21, 30],
    [10.32, 18.06, 25.8],
    [9.098383838, 15.92222222, 22.7459596],
    [8.229781818, 14.40212121, 20.57445455],
    [7.638767677, 13.36784625, 19.09691919],
    [7.271232323, 12.72465925, 18.17808081]
  ];
  List<List<double>> repFactor = [
    [0.08, 0.10, 0.12],
    [0.08, 0.10, 0.12],
    [0.12, 0.15, 0.18],
    [0.12, 0.15, 0.18],
    [0.16, 0.20, 0.24],
    [0.20, 0.25, 0.30],
    [0.24, 0.30, 0.36],
    [0.32, 0.40, 0.48],
    [0.48, 0.60, 0.72],
    [0.56, 0.70, 0.84],
    [0.68, 0.85, 1.02],
    [0.68, 0.85, 1.02],
    [0.68, 0.85, 1.02],
    [0.64, 0.80, 0.96]
  ];

  final List<double> carDepreciationPerYear = [
    0.2,
    0.14,
    0.13,
    0.12,
    0.11,
    0.10
  ];

  VehicleCost(this.yearsOwnedCar, this.carSize, this.cost, this.isNewCar,
      this.distancePerYear);

  // VehicleCost(this.yearsOwnedCar, this.carSize, this.cost, this.isNewCar, this.distancePerYear, this.fuelConsumptionPerKm);
  // factory VehicleCost.defaultVehicle() => new VehicleCost(3, 0, 300000, true, 8000);
  factory VehicleCost.defaultVehicle() {
    var vehcile = new VehicleCost(3, 0, 300000, true, 8000);
    vehcile.calculateCosts();
    return vehcile;
  }

  double calcService(double dist) {
    double service = 0;
    switch (carSize) {
      case 0:
        service = (serviceInit[0] + 0.25 * dist);
        return service;
      case 1:
        service = (serviceInit[1] + 0.175 * dist);
        return service;
      case 2:
        service = (serviceInit[2] + 0.15 * dist);
        return service;
      default:
        return 0;
    }
  }

  double calcWash(double dist) {
    double wash;
    wash = (washArray[carSize] + (4 / 80) * dist);
    return wash;
  }

  double calcInsurance() {
    double insurance;
    switch (carSize) {
      case 0:
        insurance = (insuranceInit[carSize] + 0.125 * distancePerYear);
        return insurance;
      case 1:
        insurance = (insuranceInit[carSize] + 0.150 * distancePerYear);
        return insurance;
      case 2:
        insurance = (insuranceInit[carSize] + 0.175 * distancePerYear);
        return insurance;
      default:
        return 0;
    }
  }

  double calcTires(double dist) {
    double tires;
    switch (carSize) {
      case 0:
        tires = (tireInit[0] + 0.08 * dist);
        return tires;
      case 1:
        tires = (tireInit[1] + 0.1 * dist);
        return tires;
      case 2:
        tires = (tireInit[2] + 0.12 * dist);
        return tires;
      default:
        return 0;
    }
  }

  double calcRepCost(double dist, int yr) {
    double repCost = 0;
    double accumDist = dist;

    for (int i = 0; i < yr; i++) {
      if (accumDist <= 20000) {
        repCost += repFactor[0][carSize] * dist;
      } else if (accumDist <= 30000) {
        repCost += repFactor[1][carSize] * dist;
      } else if (accumDist <= 40000) {
        repCost += repFactor[2][carSize] * dist;
      } else if (accumDist <= 50000) {
        repCost += repFactor[3][carSize] * dist;
      } else if (accumDist <= 60000) {
        repCost += repFactor[4][carSize] * dist;
      } else if (accumDist <= 70000) {
        repCost += repFactor[5][carSize] * dist;
      } else if (accumDist <= 80000) {
        repCost += repFactor[6][carSize] * dist;
      } else if (accumDist <= 90000) {
        repCost += repFactor[7][carSize] * dist;
      } else if (accumDist <= 100000) {
        repCost += repFactor[8][carSize] * dist;
      } else if (accumDist <= 110000) {
        repCost += repFactor[9][carSize] * dist;
      } else if (accumDist <= 120000) {
        repCost += repFactor[10][carSize] * dist;
      } else if (accumDist <= 130000) {
        repCost += repFactor[11][carSize] * dist;
      } else if (accumDist <= 140000) {
        repCost += repFactor[12][carSize] * dist;
      } else {
        repCost += repFactor[13][carSize] * dist;
      }
      accumDist += distancePerYear;
    }
    return repCost;
  }

  double getServicePrKm() {
    switch (carSize) {
      case 0:
        return 0.25;
      case 1:
        return 0.175;
      case 2:
        return 0.15;
      default:
        return 0.25;
    }
  }

  double getTiresPrKm() {
    switch (carSize) {
      case 0:
        return 0.08;
      case 1:
        return 0.1;
      case 2:
        return 0.12;
      default:
        return 0.08;
    }
  }

  double getInsurancePrKm() {
    switch (carSize) {
      case 0:
        return 0.125;
      case 1:
        return 0.150;
      case 2:
        return 0.175;
      default:
        return 0.125;
    }
  }

  double getWashPrKm() {
    return (4 / 80);
  }

  void calcMarginalCosts() {
    double marginalCostFuel = fuelConsumptionPerKm * fuelCostPerLiter;
    double marginalCostPr1Km = calcRepCost(1, 1) +
        getServicePrKm() +
        getWashPrKm() +
        getTiresPrKm() +
        getInsurancePrKm() +
        marginalCostFuel;

    switch (carSize) {
      case 0:
        marginalCostPr1Km += 0.01 * (cost / 20000);
        break;
      case 1:
        marginalCostPr1Km += 0.01 * (cost / 20000);
        break;
      case 2:
        marginalCostPr1Km += 0.01 * (cost / 20000);
        break;
      default:
        marginalCostPr1Km += 0.01 * (cost / 20000);
        break;
    }
    this.marginalCostPr1Km = marginalCostPr1Km;
    this.marginalCostFuel = marginalCostFuel;
  }

  void calculateCosts() {
    if (this.isNewCar) {
      fuelConsumptionPerKm = defaultFuelConsumptionPrKm[carSize];

      fuelCost = distancePerYear * fuelConsumptionPerKm * fuelCostPerLiter;
      insurance = calcInsurance();
      tires = calcTires(distancePerYear);
      repair = calcRepCost(distancePerYear, yearsOwnedCar) / yearsOwnedCar;

      calc();

      this.totCost =
          ((fuelCost + insurance + roadFee + tires + wash + service + repair) *
                  yearsOwnedCar) +
              valueLoss +
              interestLoss;
      this.totCostWithoutFuel =
          ((insurance + roadFee + tires + wash + service + repair) *
                  yearsOwnedCar) +
              valueLoss +
              interestLoss;

      this.totFuelCostPrKm = fuelConsumptionPerKm * fuelCostPerLiter;
      this.avgCostPrKm = totCost / (distancePerYear * yearsOwnedCar);
      this.avgCostPrDay = totCost / (365 * yearsOwnedCar);
    } else {
      //oldCarCalc
    }
  }

  // Author Mangus Tangen and Celine Mihn
  void calc() {
    // Variables related to normal value loss (no km correction)
    double normalValueLoss = 0;
    double totNormalValueLoss = 0;
    double normalCurrentValue = cost;

    // Variables related to km correction
    double correctedLossDiff = 0;
    double totCorrectedLossDiff = 0;
    double correctedCurrentValue = cost;

    // Losses related to interest
    double totInterestLoss = 0;
    double interestLoss = 0;

    for (int i = 0; i < yearsOwnedCar; i++) {
      correctedLossDiff = (getDistanceFactor(i) *
          ((distancePerYear / distancePerYear) - 1) *
          100);
      totCorrectedLossDiff += correctedLossDiff;
      if (i >= 5) {
        normalValueLoss = normalCurrentValue * valueLossRateArray[5];
        totNormalValueLoss += normalValueLoss;
      } else {
        normalValueLoss = normalCurrentValue * valueLossRateArray[i];
        totNormalValueLoss += normalValueLoss;
      }

      interestLoss = taxFactor *
          (correctedCurrentValue) *
          interest *
          (1 -
              (((normalValueLoss + correctedLossDiff) /
                      (correctedCurrentValue)) /
                  2));
      totInterestLoss += interestLoss;

      normalCurrentValue = cost - totNormalValueLoss;
      correctedCurrentValue = cost - totNormalValueLoss - totCorrectedLossDiff;
    }

    valueLoss = totNormalValueLoss + totCorrectedLossDiff;
    interestLoss = totInterestLoss;
  }

  double getDistanceFactor(int yr) {
    if (yr >= 5) {
      yr = 5;
    }
    return distFactor[yr][carSize];
  }

  double getAverageCurrentCarCost() {
    int hour = DateTime.now().hour;
    return avgCostPrDay / 24 * hour;
  }

  double getCostToday() {
    int hour = DateTime.now().hour;
    //float dist = db.getDrivingDistanceToday();
    //TODO: hent distance today
    double dist = 20;
    double costToday =
        ((totCostWithoutFuel / (24 * 365 * yearsOwnedCar)) * hour) +
            ((dist / 1000) * totFuelCostPrKm);

    return costToday;
  }
}
