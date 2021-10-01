import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  final Color backgroundColor;
  final String emoji;
  const CircleIcon(
      {Key? key, required this.backgroundColor, required this.emoji})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: this.backgroundColor, shape: BoxShape.circle),
      child: Container(
          padding: EdgeInsets.all(8),
          child: Text(
            this.emoji,
            style: TextStyle(fontSize: 35),
          )),
    );
  }
}