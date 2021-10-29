class ActiveMinutes {
  static double calculateActiveMinutesFromWalking(double distance) {
    return 10 * distance; //10 min per km, find accurate formula
  }

  static double calculateActiveMinutesFromCycling(double distance) {
    return 3 * distance; //3 min per km, find accurate formula
  }
}
