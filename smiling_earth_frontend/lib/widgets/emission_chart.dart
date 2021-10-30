import 'dart:math';

import 'package:flutter/material.dart';

class SmilingEarthEmissionChart extends StatelessWidget {
  final double? energyEmission;
  final double? transportEmission;
  final double goal;
  SmilingEarthEmissionChart({
    Key? key,
    this.energyEmission,
    required this.transportEmission,
    required this.goal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          width: 300,
          child: CustomPaint(
              foregroundPainter: EmissionChart(
                  energyEmission! / goal, transportEmission! / goal),
              child: Container(
                height: 300,
                width: 300,
                child: Center(
                    child: Image(
                        height: 160,
                        width: 160,
                        image: _getSmilingEarth(
                            (transportEmission! + energyEmission!) / goal))),
              )),
        ),
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
        ])
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

class SmilingEarthChartSkeleton extends StatelessWidget {
  const SmilingEarthChartSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
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
