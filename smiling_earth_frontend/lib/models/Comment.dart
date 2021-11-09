import 'package:smiling_earth_frontend/models/user.dart';

class Comment {
  final UserProfileDto user;
  final String comment;
  final DateTime dateTime;

  Comment({
    required this.user,
    required this.comment,
    required this.dateTime,
  });
}
