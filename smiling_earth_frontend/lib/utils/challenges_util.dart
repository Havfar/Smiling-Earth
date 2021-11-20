import 'package:smiling_earth_frontend/cubit/challenge/challenge_client.dart';
import 'package:smiling_earth_frontend/models/challenge.dart';
import 'package:smiling_earth_frontend/utils/activity_util.dart';
import 'package:smiling_earth_frontend/utils/services/activity_db_manager.dart';

class ChallengesUtil {
  ChallengesClient _client = ChallengesClient();

  Future<void> updateChallenges() async {
    var challenges = await _client.getJoinedChallenges();
    for (var challenge in challenges) {
      updateChallengeProgress(challenge.challenge);
    }
  }

  Future<void> updateChallengeProgress(ChallengeDto challenge) async {
    double progress = await calculateProgress(challenge);
    return _client.updateProgress(challenge, progress.round());
  }

  Future<double> calculateProgress(ChallengeDto challenge) async {
    var challengeType = ChallengeType.values[challenge.challengeType];

    switch (challengeType) {
      case ChallengeType.ACTIVITY_GROUP:
        List<int> types = [];
        for (var type in challenge.challengeTypeFeature) {
          if (int.tryParse(type.toString()) != null) {
            types.add(int.parse(type.toString()));
          }
        }
        return calculateTotalTimeInActivityGroup(types);
      case ChallengeType.ACTIVITY_TYPE:
        var type = AppActivityType.values[challenge.challengeTypeFeature[0]];
        return calculateTotalTimeInActivityType(type);

      case ChallengeType.ACTIVITY_TAG:
        var type = 'Commute';
        return calculateTotalTimeInActivityTag(type);

      default:
        return 0;
    }
  }
}

Future<double> calculateTotalTimeInActivityGroup(List<int> types) async {
  double durationInSeconds =
      await ActivityDatabaseManager.instance.getDurationOfActivityGroup(types);
  double duration = durationInSeconds / 60;
  return duration;
}

Future<double> calculateTotalTimeInActivityType(AppActivityType type) async {
  double durationInSeconds =
      await ActivityDatabaseManager.instance.getDurationOfActivity(type.index);
  double duration = durationInSeconds / 60;
  return duration;
}

Future<double> calculateTotalTimeInActivityTag(String tag) async {
  double durationInSeconds =
      await ActivityDatabaseManager.instance.getDurationOfActivityWithTag(tag);
  double duration = durationInSeconds / 60;
  return duration;
}

//The different challengestype.
//ACTIVITY_GROUP = a set of activities e.g. {Bus, train, tram}, {Walk, run, bike}. ACTIVITY_TYPE = one kind of actvity. ACTIVITY_TAG = all activites with the tag. TICKER = tap to progress e.g. 5 meat free days.
enum ChallengeType {
  NULL,
  ACTIVITY_GROUP,
  ACTIVITY_TYPE,
  ACTIVITY_TAG,
  TICKER,
}
