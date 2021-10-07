import 'package:smiling_earth_frontend/models/emission.dart';
import 'package:smiling_earth_frontend/models/user.dart';

class TeamsDto {
  final int? id;
  final String name;
  final int? memeberCount;
  final double? emissions;
  final String symbol;

  TeamsDto(this.id, this.name, this.memeberCount, this.emissions, this.symbol);

  factory TeamsDto.fromJson(Map<String, dynamic> json) => new TeamsDto(
      json['id'],
      json['name'],
      json['memeber_count'],
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

  TeamDetailedDto(this.id, this.name, this.symbol, this.description,
      this.location, this.emissions);

  factory TeamDetailedDto.fromJson(Map<String, dynamic> json) =>
      new TeamDetailedDto(
          json['id'],
          json['name'],
          json['symbol'],
          json['description'],
          json['location'],
          SimpleEmissionDto.fromJson(json['emissions']));
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
