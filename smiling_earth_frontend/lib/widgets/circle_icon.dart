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

class CircleIconSkeleton extends StatelessWidget {
  const CircleIconSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: Colors.grey.shade400, shape: BoxShape.circle),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade300, shape: BoxShape.circle),
              padding: EdgeInsets.all(8),
              child: Text('')),
        ),
        Container(
            margin: EdgeInsets.only(top: 5),
            height: 5,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ))
      ],
    );
  }
}

class CircleIconPlaceHolder extends StatelessWidget {
  const CircleIconPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: Colors.grey.shade300, shape: BoxShape.circle),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade300, shape: BoxShape.circle),
              padding: EdgeInsets.all(8),
              child: Text('')),
        ),
      ],
    );
  }
}
