import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/models/active_minutes.dart';
import 'package:smiling_earth_frontend/models/calories.dart';
import 'package:smiling_earth_frontend/models/transportation.dart';
import 'package:smiling_earth_frontend/models/vehicle_cost.dart';
import 'package:smiling_earth_frontend/pages/emission_estimation/emission_estimation.dart';
import 'package:smiling_earth_frontend/pages/emission_estimation/emission_estimation_cycling.dart';
import 'package:smiling_earth_frontend/pages/emission_estimation/emission_estimation_driving.dart';
import 'package:smiling_earth_frontend/pages/home/home_page.dart';
import 'package:smiling_earth_frontend/widgets/emission_chart.dart';
import 'package:smiling_earth_frontend/widgets/emission_header.dart';

class WalkEmissionEstimatePage extends StatefulWidget {
  WalkEmissionEstimatePage({Key? key}) : super(key: key);

  @override
  _WalkEmissionEstimatePageState createState() =>
      _WalkEmissionEstimatePageState();
}

class _WalkEmissionEstimatePageState extends State<WalkEmissionEstimatePage> {
  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        // builder: (BuildContext context) => TeamsDetailedPage(id: id),
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              EmissionEstimatePage(),
          transitionDuration: Duration.zero,
        ));
        break;
      case 1:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              WalkEmissionEstimatePage(),
          transitionDuration: Duration.zero,
        ));
        break;
      case 2:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              CyclingEmissionEstimatePage(),
          transitionDuration: Duration.zero,
        ));
        break;
      case 3:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              DriveEmissionEstimatePage(),
          transitionDuration: Duration.zero,
        ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomePage())),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: ListView(
          children: [
            // BuildHeaderToolbar(),
            BuildWalkingEstimation()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
          type: BottomNavigationBarType.fixed,
          onTap: (
            index,
          ) =>
              _onTap(context, index),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.wb_sunny),
              label: 'Solar panel',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_walk),
              label: 'Walk',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_bike),
              label: 'Cycle',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.electric_car),
              label: 'Electric car',
            ),
          ]));
}

class BuildWalkingEstimation extends StatefulWidget {
  const BuildWalkingEstimation({
    Key? key,
  }) : super(key: key);

  @override
  State<BuildWalkingEstimation> createState() => _BuildWalkingEstimationState();
}

class _BuildWalkingEstimationState extends State<BuildWalkingEstimation> {
  double _sliderValue = 0;
  VehicleCost vehicleCost = VehicleCost.defaultVehicle();
  Calories caloriesEstimator = Calories(null, null, null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        BuildHeaderToolbar(
          distance: (_sliderValue * 100).round(),
          electricity: null,
          kcal: caloriesEstimator
              .calculateCaloriesFromWalkingDistance((_sliderValue * 100))
              .round(),
          money: _getSavingsFromWalking(((1 - _sliderValue) * 100)).round(),
          time: ActiveMinutes.calculateActiveMinutesFromWalking(
                  (_sliderValue * 100))
              .round(),
        ),
        Text('See how much you can save by walking instead of driving'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.directions_walk),
                    Text(
                      (_sliderValue * 100).roundToDouble().toString() + ' km',
                      textAlign: TextAlign.center,
                    )
                  ]),
            ),
            Container(
              width: 220,
              child: Slider(
                  value: _sliderValue,
                  onChanged: (newValue) => setState(() {
                        _sliderValue = newValue;
                      })),
            ),
            Container(
              width: 60,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.directions_car),
                    Text(
                      ((1 - _sliderValue) * 100).roundToDouble().toString() +
                          ' km',
                      textAlign: TextAlign.center,
                    )
                  ]),
            ),
          ],
        ),
        SmilingEarthEmissionChart(
          energyEmission: 0,
          transportEmission: Transportation.getGasolineCarEmissionByDistance(
              (1 - _sliderValue) * 100),
          goal: Transportation.getGasolineCarEmissionByDistance(100),
        ),
        ListTile(
          leading: Text('💰', style: TextStyle(fontSize: 22)),
          title: Text('By walking you could save : '),
          subtitle: Text('(per day)'),
          trailing: Text(_getSavingsFromWalking((1 - _sliderValue) * 100)
                  .roundToDouble()
                  .toString() +
              ' kr'),
        ),
        ListTile(
          leading: Text('☀️', style: TextStyle(fontSize: 22)),
          title: Text('Days to finance you solar roof: '),
          trailing: Text(
              _calculateDaysLeftForSolarRoof((1 - _sliderValue) * 100)
                  .round()
                  .toString()),
        )
      ],
    );
  }

  double _getSavingsFromWalking(double distance) {
    vehicleCost.calculateCosts();

    double savings = (100 - distance) * vehicleCost.avgCostPrKm;
    return savings;
  }

  double _calculateDaysLeftForSolarRoof(double distance) {
    final int SOLAR_PANEL_PRICE = 100000;
    double savings = _getSavingsFromWalking(distance);
    if (savings == 0) {
      return -1;
    }
    return SOLAR_PANEL_PRICE / savings;
  }
}
