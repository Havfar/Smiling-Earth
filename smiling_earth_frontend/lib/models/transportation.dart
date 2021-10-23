class Transportation {
  static final double gasolinoEmission = 0.2392; // kgCO2e/L
  static final double dieselEmission = 0.2640; // kgCO2e/L
  static final double electricEmission = 0;
  static final double airtravelEmission = 2.5; // kgCO2e/min
  static final double citySpeed = 30; // km\h
  static final double highwaySpeed = 80; // km\h

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

  static double getDieselCarEmission(Duration duration) {
    //Future versions should track distance covered.
    var speed = duration.inMinutes > 30 ? highwaySpeed : citySpeed;
    var distance = duration.inMinutes / 60 * speed;
    return dieselEmission * _getCarLiterPerKm() * distance;
  }

  static double getGasolineCarEmission(Duration duration) {
    //Future versions should track distance covered.
    var speed = duration.inMinutes > 30 ? highwaySpeed : citySpeed;
    var distance = duration.inMinutes / 60 * speed;
    return gasolinoEmission * _getCarLiterPerKm() * distance;
  }

  static double getElectricVehicleEmission(Duration duration) {
    //Future versions should review the emissions of electric vehicles.
    return electricEmission * duration.inMinutes;
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
}
