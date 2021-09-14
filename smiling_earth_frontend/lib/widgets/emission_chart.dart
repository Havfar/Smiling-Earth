import 'dart:math';

import 'package:flutter/material.dart';

class SmilingEarthEmissionChart extends StatelessWidget {
  final double energyEmissionPercentage;
  final double transportEmissionPercentage;
  const SmilingEarthEmissionChart({
    Key? key,
    required this.energyEmissionPercentage,
    required this.transportEmissionPercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: CustomPaint(
          foregroundPainter: EmissionChart(
              energyEmissionPercentage, transportEmissionPercentage),
          child: Container(
            height: 300,
            width: 300,
            child: Center(
                child: Image(
                    height: 160,
                    width: 160,
                    image: AssetImage('assets/img/smiling-earth/earth1.png'))),
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
    double strokeWidth = 30;
    Offset center = Offset(size.width * 0.5, size.height * 0.5);
    double radius = 110;
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
