import 'package:smiling_earth_frontend/models/User.dart';

Comment mockComment = Comment(
    comment:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Enim in eros, sapien neque nulla cursus eget.",
    user: mockUser,
    dateTime: DateTime.now());

class Comment {
  final User user;
  final String comment;
  final DateTime dateTime;

  Comment({
    required this.user,
    required this.comment,
    required this.dateTime,
  });
}
