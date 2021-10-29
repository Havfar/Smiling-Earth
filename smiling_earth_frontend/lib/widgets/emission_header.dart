import 'package:flutter/material.dart';

class BuildHeaderToolbar extends StatelessWidget {
  final int? kcal;
  final int? time;
  final int? money;
  final int? distance;
  final int? electricity;

  const BuildHeaderToolbar({
    Key? key,
    required this.kcal,
    required this.time,
    required this.money,
    required this.distance,
    required this.electricity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
      margin: EdgeInsets.only(top: 20, bottom: 30),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              kcal != null ? kcal.toString() : '-',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "kcal",
              style: TextStyle(color: Colors.black87),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              time != null ? time.toString() : '-',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "min",
              style: TextStyle(color: Colors.black87),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              money != null ? money.toString() : '-',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "kr",
              style: TextStyle(color: Colors.black87),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              distance != null ? distance.toString() : '-',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "km",
              style: TextStyle(color: Colors.black87),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              electricity != null ? electricity.toString() : '-',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "kWh",
              style: TextStyle(color: Colors.black87),
            )
          ],
        )
      ]),
    );
  }
}
