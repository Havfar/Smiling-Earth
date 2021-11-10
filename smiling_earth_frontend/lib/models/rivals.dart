import 'package:smiling_earth_frontend/models/teams.dart';

class RivalDto {
  final int? id;
  final TeamsDto sender;
  final TeamsDto receiver;
  final String status;

  RivalDto(this.id, this.sender, this.receiver, this.status);

  factory RivalDto.fromJson(Map<String, dynamic> json) => new RivalDto(
      json['id'],
      TeamsDto.fromJson(json['sender']),
      TeamsDto.fromJson(json['receiver']),
      json['status']);

  Map<String, dynamic> toMap() {
    return {
      'id': id!,
      'sender': sender.id,
      'receiver': receiver.id,
      'status': status
    };
  }
}

class SimpleRivalDto {
  final int sender;
  final int receiver;

  SimpleRivalDto(this.sender, this.receiver);

  Map<String, int> toMap() {
    return {'sender': sender, 'receiver': receiver};
  }
}
