import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/models/avatar.dart';

class UserAvatar extends StatelessWidget {
  UserAvatar({
    Key? key,
    required this.avatar,
  }) : super(key: key);

  final Avatar avatar;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: 60,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          shape: BoxShape.circle,
        ),
        child: Avatar.toSvg(avatar));
  }
}
