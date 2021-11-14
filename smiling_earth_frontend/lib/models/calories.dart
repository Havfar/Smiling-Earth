class Calories {
  final String? gender;
  final double? weight;
  final int? age;

  Calories(this.gender, this.weight, this.age);

  static double calculateWalkingDistance(int durationInMinutes) {
    double averageWalkingSpeed = 5;
    double distance = averageWalkingSpeed * durationInMinutes / 60;
    return distance;
  }

  static double calculateRunningDistance(int durationInMinutes) {
    double averageRunningSpeed = 10;
    double distance = averageRunningSpeed * durationInMinutes / 60;
    return distance;
  }

  static double calculateCyclingDistance(int durationInMinutes) {
    double averageWalkingSpeed = 15;
    double distance = averageWalkingSpeed * durationInMinutes / 60;
    return distance;
  }

  double calculateCaloriesFromWalkingDuration(int durationInMinutes) {
    double distance = calculateWalkingDistance(durationInMinutes);
    return calculateCaloriesFromWalkingDistance(distance);
  }

  double calculateCaloriesFromRunningDuration(int durationInMinutes) {
    double distance = calculateRunningDistance(durationInMinutes);
    return calculateCaloriesFromWalkingDistance(distance);
  }

  double calculateCaloriesFromWalkingDistance(double distance) {
    return 76 * distance; //TODO: accurate formula
  }

  double calculateCaloriesFromRunningDistance(double distance) {
    return 60 * distance; //TODO: accurate formula
  }

  double calculateCaloriesFromCyclingDuration(int durationInMinutes) {
    double distance = calculateCyclingDistance(durationInMinutes);
    return calculateCaloriesFromCyclingDistance(distance);
  }

  double calculateCaloriesFromCyclingDistance(double distance) {
    return 30 * distance; //TODO: accurate formula
  }
}
