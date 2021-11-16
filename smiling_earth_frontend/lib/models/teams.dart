import 'package:smiling_earth_frontend/models/emission.dart';
import 'package:smiling_earth_frontend/models/user.dart';

class TeamsDto {
  final int? id;
  final String name;
  final int? membersCount;
  final double? emissions;
  final String symbol;

  TeamsDto(this.id, this.name, this.membersCount, this.emissions, this.symbol);

  factory TeamsDto.fromJson(Map<String, dynamic> json) => new TeamsDto(
      json['id'],
      json['name'],
      json['members_count'],
      json['emissions'],
      json['symbol']);
}

class TeamDetailedDto {
  final int? id;
  final String name;
  final String symbol;
  final String? description;
  final String? location;
  final SimpleEmissionDto emissions;
  final int? membersCount;

  TeamDetailedDto(this.id, this.name, this.symbol, this.description,
      this.location, this.emissions, this.membersCount);

  factory TeamDetailedDto.fromJson(Map<String, dynamic> json) =>
      new TeamDetailedDto(
        json['id'],
        json['name'],
        json['symbol'],
        json['description'],
        json['location'],
        SimpleEmissionDto.fromJson(json['emissions']),
        json['members_count'],
      );
}

class TeamMemberDto {
  final int? id;
  final UserProfileDto user;
  final double emissions;

  TeamMemberDto(this.id, this.user, this.emissions);

  factory TeamMemberDto.fromJson(Map<String, dynamic> json) =>
      new TeamMemberDto(
          json['id'], UserProfileDto.fromJson(json['user']), json['emissions']);
}
