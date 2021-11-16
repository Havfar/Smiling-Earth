import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/models/active_minutes.dart';
import 'package:smiling_earth_frontend/models/calories.dart';
import 'package:smiling_earth_frontend/models/transportation.dart';
import 'package:smiling_earth_frontend/models/vehicle_cost.dart';
import 'package:smiling_earth_frontend/pages/emission_estimation/emission_estimation.dart';
import 'package:smiling_earth_frontend/pages/emission_estimation/emission_estimation_driving.dart';
import 'package:smiling_earth_frontend/pages/emission_estimation/emission_estimation_walk.dart';
import 'package:smiling_earth_frontend/pages/home/home_page.dart';
import 'package:smiling_earth_frontend/widgets/emission_chart.dart';
import 'package:smiling_earth_frontend/widgets/emission_header.dart';

class CyclingEmissionEstimatePage extends StatefulWidget {
  CyclingEmissionEstimatePage({Key? key}) : super(key: key);

  @override
  _CyclingEmissionEstimatePageState createState() =>
      _CyclingEmissionEstimatePageState();
}

class _CyclingEmissionEstimatePageState
    extends State<CyclingEmissionEstimatePage> {
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
          children: [BuildCyclingEstimation()],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 2,
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
              icon: Icon(Icons.directions_bike),
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

class BuildCyclingEstimation extends StatefulWidget {
  const BuildCyclingEstimation({
    Key? key,
  }) : super(key: key);

  @override
  State<BuildCyclingEstimation> createState() => _BuildCyclingEstimationState();
}

class _BuildCyclingEstimationState extends State<BuildCyclingEstimation> {
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
              .calculateCaloriesFromCyclingDistance((_sliderValue * 100))
              .round(),
          money: _getSavingsFromCycling(((1 - _sliderValue) * 100)).round(),
          time: ActiveMinutes.calculateActiveMinutesFromCycling(
                  (_sliderValue * 100))
              .round(),
          showPersonalMessage: false,
          isTeam: false,
        ),
        Text('See how much you can save by Cycling instead of driving'),
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
          hideTitle: true,
          energyEmission: 0,
          transportEmission: Transportation.getGasolineCarEmissionByDistance(
              (1 - _sliderValue) * 100),
          goal: Transportation.getGasolineCarEmissionByDistance(100),
        ),
        ListTile(
          leading: Text('💰', style: TextStyle(fontSize: 22)),
          title: Text('By Cycling you could save : '),
          subtitle: Text('(per day)'),
          trailing: Text(_getSavingsFromCycling((1 - _sliderValue) * 100)
                  .roundToDouble()
                  .toString() +
              ' kr'),
        ),
        ListTile(
          leading: Text('☀️', style: TextStyle(fontSize: 22)),
          title: Text('Days to finance a solar roof: '),
          trailing: Text(
              _calculateDaysLeftForSolarRoof((1 - _sliderValue) * 100)
                  .round()
                  .toString()),
        )
      ],
    );
  }

  double _getSavingsFromCycling(double distance) {
    vehicleCost.calculateCosts();

    double savings = (100 - distance) * vehicleCost.avgCostPrKm;
    return savings;
  }

  double _calculateDaysLeftForSolarRoof(double distance) {
    final int SOLAR_PANEL_PRICE = 100000;
    double savings = _getSavingsFromCycling(distance);
    if (savings == 0) {
      return -1;
    }
    return SOLAR_PANEL_PRICE / savings;
  }
}
