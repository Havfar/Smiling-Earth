import 'package:smiling_earth_frontend/models/teams.dart';
import 'package:smiling_earth_frontend/models/user.dart';

class ChallengeDto {
  final int? id;
  final String title;
  final String description;
  final String symbol;
  final String backgroundColor;
  final int goal;
  final int challengeType;
  final List<dynamic> challengeTypeFeature;

  ChallengeDto(
      this.id,
      this.title,
      this.description,
      this.symbol,
      this.backgroundColor,
      this.goal,
      this.challengeType,
      this.challengeTypeFeature);

  factory ChallengeDto.fromJson(Map<String, dynamic> json) => (new ChallengeDto(
      json['id'],
      json['title'],
      json['description'],
      json['symbol'],
      json['background_color'],
      json['goal'],
      json['challenge_type'],
      json['feature_list']));
}

class JoinedChallengeDto {
  final int? id;
  final int score;
  final int progress;
  final ChallengeDto challenge;

  JoinedChallengeDto(this.id, this.score, this.progress, this.challenge);

  factory JoinedChallengeDto.fromJson(Map<String, dynamic> json) =>
      (new JoinedChallengeDto(json['id'], json['score'], json['progress'],
          ChallengeDto.fromJson(json['challenge'])));

  double calulateProgress() {
    if (challenge.goal == 0) {
      return 0;
    }
    return progress.toDouble() / challenge.goal.toDouble();
  }
}

class DetailedChallengeDto {
  final int? id;
  final String title;
  final String description;
  final String symbol;
  final String backgroundColor;
  final bool isTeamChallenge;
  final List<dynamic> leaderboard;
  // final List<TeamChallengeDto>? teamLeaderboard;

  DetailedChallengeDto(
      this.id,
      this.title,
      this.description,
      this.symbol,
      this.backgroundColor,
      this.isTeamChallenge,
      // this.userLeaderboard,
      this.leaderboard);

  factory DetailedChallengeDto.fromJson(Map<String, dynamic> json) =>
      (new DetailedChallengeDto(
          json['id'],
          json['title'],
          json['description'],
          json['symbol'],
          json['background_color'],
          json['is_team_challenge'],
          (json['leaderboard'] as List).map((listItemJson) {
            if (json['is_team_challenge']) {
              return TeamChallengeDto.fromJson(listItemJson);
            } else {
              return UserChallengeDto.fromJson(listItemJson);
            }
          }).toList()));
}

class UserChallengeDto {
  final int? id;
  final UserProfileDto user;
  final int score;
  final int progress;

  UserChallengeDto(this.id, this.user, this.score, this.progress);

  factory UserChallengeDto.fromJson(Map<String, dynamic> json) =>
      (new UserChallengeDto(json['id'], UserProfileDto.fromJson(json['user']),
          json['score'], json['progress']));
}

class TeamChallengeDto {
  final int? id;
  final TeamsDto team;
  final int score;
  final int progress;

  TeamChallengeDto(this.id, this.team, this.score, this.progress);

  factory TeamChallengeDto.fromJson(Map<String, dynamic> json) =>
      (new TeamChallengeDto(json['id'], TeamsDto.fromJson(json['team']),
          json['score'], json['progress']));
}
