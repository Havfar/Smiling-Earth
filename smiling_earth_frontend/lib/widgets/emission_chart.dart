import 'dart:math';

import 'package:flutter/material.dart';

class SmilingEarthEmissionChart extends StatelessWidget {
  final bool hideTitle;
  final double? energyEmission;
  final double? transportEmission;
  final double goal;
  SmilingEarthEmissionChart({
    Key? key,
    this.energyEmission,
    required this.transportEmission,
    required this.goal,
    required this.hideTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 220,
          width: 220,
          child: CustomPaint(
              foregroundPainter: EmissionChart(
                  energyEmission! / goal, transportEmission! / goal),
              child: Container(
                height: 250,
                width: 250,
                child: Center(
                    child: Image(
                        height: 150,
                        width: 150,
                        image: _getSmilingEarth(
                            (transportEmission! + energyEmission!) / goal))),
              )),
        ),
        Column(
          children: [
            BuildTitle(hideTitle),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 12,
                          height: 5,
                          decoration: BoxDecoration(color: Colors.blue)),
                      SizedBox(width: 5),
                      Text('Energy'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                      energyEmission != null
                          ? energyEmission!.roundToDouble().toString()
                          : '-',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      )),
                  Text('kg CO2'),
                ],
              ),
              SizedBox(width: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 12,
                          height: 5,
                          decoration: BoxDecoration(color: Colors.green)),
                      SizedBox(width: 5),
                      Text('Transport'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                      transportEmission != null
                          ? transportEmission!.roundToDouble().toString()
                          : '-',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      )),
                  Text('kg CO2'),
                ],
              ),
              SizedBox(width: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Total'),
                  SizedBox(height: 10),
                  Text(_getCombinedEmission().toString(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      )),
                  Text('kg CO2'),
                ],
              )
            ]),
          ],
        )
      ],
    );
  }

  double _getCombinedEmission() {
    double emission = 0;
    if (transportEmission != null) {
      emission += transportEmission!;
    }
    if (energyEmission != null) {
      emission += energyEmission!;
    }
    return emission.roundToDouble();
  }

  AssetImage _getSmilingEarth(double percentage) {
    if (percentage > 0.9) {
      return AssetImage('assets/img/smiling-earth/earth5.png');
    } else if (percentage > 0.7) {
      return AssetImage('assets/img/smiling-earth/earth4.png');
    } else if (percentage > 0.5) {
      return AssetImage('assets/img/smiling-earth/earth3.png');
    } else if (percentage > 0.3) {
      return AssetImage('assets/img/smiling-earth/earth2.png');
    } else {
      return AssetImage('assets/img/smiling-earth/earth1.png');
    }
  }
}

class BuildTitle extends StatelessWidget {
  final bool hide;
  const BuildTitle(
    this.hide, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.hide) {
      return SizedBox(height: 10);
    }
    return Column(
      children: [
        Text("So far this month you have emitted ",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            )),
        SizedBox(height: 10)
      ],
    );
  }
}

class SmilingEarthChartSkeleton extends StatelessWidget {
  const SmilingEarthChartSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: 220,
      child: CustomPaint(
          foregroundPainter: EmissionChart(0, 0),
          child: Container(
            height: 300,
            width: 300,
            child: Center(
                child: Image(
                    height: 160,
                    width: 160,
                    image: AssetImage('assets/img/smiling-earth/earth.png'))),
          )),
    );
  }
}

class EmissionChart extends CustomPainter {
  final double energyEmissionPercentage;
  final double transportEmissionPercentage;

  EmissionChart(
      this.energyEmissionPercentage, this.transportEmissionPercentage);

  @override
  void paint(Canvas canvas, Size size) {
    double angleEnergy = 2 * pi * energyEmissionPercentage;
    double angleTransport = 2 * pi * transportEmissionPercentage;
    double strokeWidth = 22;
    Offset center = Offset(size.width * 0.5, size.height * 0.5);
    double radius = 90;
    double startAngle = 4.7;

    var paint = Paint()
      ..color = Colors.black12
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    var paintEnergy = Paint()
      ..color = Colors.blue
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, paint);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        angleEnergy, false, paintEnergy);

    var paintTransport = Paint()
      ..color = Colors.green
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        startAngle + angleEnergy, angleTransport, false, paintTransport);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
