import 'package:smiling_earth_frontend/models/energy.dart';

class Transportation {
  static final double gasolineEmission = 2.392; // kgCO2e/L
  static final double dieselEmission = 2.640; // kgCO2e/L
  static final double electricEmission = 0;
  static final double airtravelEmission = 2.5; // kgCO2e/min
  static final double citySpeed = 30; // km\h
  static final double highwaySpeed = 80; // km\h
  static final double fuelCostPerLiter = 14;

  static double _getCarLiterPerKm() {
    // todo: fetch car consumption
    var defualtConsumption = 0.06;
    return defualtConsumption;
  }

  static double _getBusLitrePerKm() {
    // todo: fetch bus consumption
    var defualtConsumption = 0.6;
    return defualtConsumption;
  }

  static double _getElectricCarKWhPerKm() {
    // todo: fetch bus consumption
    var defualtConsumption = 0.2;
    return defualtConsumption;
  }

  static double getDieselCarEmission(Duration duration) {
    //Future versions should track distance covered.
    var speed = duration.inMinutes.abs() > 30 ? highwaySpeed : citySpeed;
    var distance = duration.inMinutes / 60 * speed;
    return dieselEmission * _getCarLiterPerKm() * distance;
  }

  static double getGasolineCarEmission(Duration duration) {
    //Future versions should track distance covered.
    // var speed = duration.inMinutes > 30 ? highwaySpeed : citySpeed;
    var distance = convertCarDurationToDistance(duration.inMinutes.abs());
    return getGasolineCarEmissionByDistance(distance);
  }

  static double getGasolineCarEmissionByDistance(double distance) {
    print(gasolineEmission * _getCarLiterPerKm() * distance);
    return gasolineEmission * _getCarLiterPerKm() * distance;
  }

  static double convertCarDurationToDistance(int durationInMinutes) {
    var speed = durationInMinutes > 30 ? highwaySpeed : citySpeed;
    var distance = durationInMinutes / 60 * speed;
    return distance;
  }

  static double getElectricVehicleEmission(Duration duration) {
    //Future versions should review the emissions of electric vehicles.
    return electricEmission * duration.inMinutes;
  }

  static double compareCostElectricVsGasolineCar(double distance) {
    var electricCarCost =
        distance * _getElectricCarKWhPerKm() * Energy.electricityPrice;
    var gasolineCarCost = distance * _getCarLiterPerKm() * fuelCostPerLiter;
    return gasolineCarCost - electricCarCost;
  }

  static double getFlyingEmission(Duration duration) {
    //Future versions should review the emissions of  air travel.
    return duration.inMinutes * airtravelEmission;
  }

  static double getBusEmission(Duration duration) {
    //Future versions should review the emissions of  air travel.

    var speed = duration.inMinutes > 30 ? highwaySpeed : citySpeed;
    var distance = duration.inMinutes / 60 * speed;
    var numberOfPassengers = 20;
    return dieselEmission * _getBusLitrePerKm() * distance / numberOfPassengers;
  }

  // static double getFlyingEmission(Duration duration) {
  //   //Future versions should review the emissions of  air travel.
  //   return duration.inMinutes * airtravelEmission;
  // }
  static double calculateSavingsFromTransport() {
    return 10;
  }
}
