import 'package:smiling_earth_frontend/models/user.dart';

class NotificationDto {
  final int? id;
  final int notificationType;
  final UserProfileDto? fromUser;
  final int toUser;
  final String? message;
  final int? post;
  final int? comment;
  final int? challenge;
  final int? follow;
  final bool userHasSeen;
  final DateTime? timestamp;

  NotificationDto(
      this.id,
      this.notificationType,
      this.fromUser,
      this.toUser,
      this.message,
      this.post,
      this.comment,
      this.challenge,
      this.follow,
      this.userHasSeen,
      this.timestamp);

  factory NotificationDto.fromJson(Map<String, dynamic> json) {
    return new NotificationDto(
        json['id'],
        json['notification_type'],
        json['from_user'] != null
            ? UserProfileDto.fromJson(json['from_user'])
            : null,
        json['to_user'],
        json['message'],
        json['post'],
        json['comment'],
        json['challenge'],
        json['follow'],
        json['user_has_seen'],
        DateTime.tryParse(json['timestamp'].toString()));
  }
}
