class Calories {
  final String? gender;
  final double? weight;
  final int? age;

  Calories(this.gender, this.weight, this.age);

  double calculateCaloriesFromWalkingDuration(int durationInMinutes) {
    double averageWalkingSpeed = 5;
    double distance = averageWalkingSpeed * durationInMinutes / 60;
    return calculateCaloriesFromWalkingDistance(distance);
  }

  double calculateCaloriesFromWalkingDistance(double distance) {
    return 7 * distance; //TODO: accurate formula
  }

  double calculateCaloriesFromCyclingDuration(int durationInMinutes) {
    double averageWalkingSpeed = 15;
    double distance = averageWalkingSpeed * durationInMinutes / 60;
    return calculateCaloriesFromCyclingDistance(distance);
  }

  double calculateCaloriesFromCyclingDistance(double distance) {
    return 2 * distance; //TODO: accurate formula
  }
}
