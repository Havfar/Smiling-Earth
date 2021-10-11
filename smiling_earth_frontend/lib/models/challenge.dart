import 'package:smiling_earth_frontend/models/user.dart';

class ChallengeDto {
  final int? id;
  final String title;
  final String description;
  final String symbol;
  final String backgroundColor;

  ChallengeDto(
      this.id, this.title, this.description, this.symbol, this.backgroundColor);

  factory ChallengeDto.fromJson(Map<String, dynamic> json) => (new ChallengeDto(
      json['id'],
      json['title'],
      json['description'],
      json['symbol'],
      json['background_color']));
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
}

class DetailedChallengeDto {
  final int? id;
  final String title;
  final String description;
  final String symbol;
  final String backgroundColor;
  final List<UserChallengeDto> leaderboard;

  DetailedChallengeDto(this.id, this.title, this.description, this.symbol,
      this.backgroundColor, this.leaderboard);

  factory DetailedChallengeDto.fromJson(Map<String, dynamic> json) =>
      (new DetailedChallengeDto(
          json['id'],
          json['title'],
          json['description'],
          json['symbol'],
          json['background_color'],
          (json['leaderboard'] as List)
              .map((userJson) => UserChallengeDto.fromJson(userJson))
              .toList()));
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
