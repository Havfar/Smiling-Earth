import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/pages/emission_estimation/emission_estimation.dart';
import 'package:smiling_earth_frontend/pages/emission_estimation/emission_estimation_driving.dart';
import 'package:smiling_earth_frontend/pages/emission_estimation/emission_estimation_walk.dart';
import 'package:smiling_earth_frontend/pages/home/home_page.dart';
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
        child: Column(
          children: [
            BuildHeaderToolbar(
              distance: null,
              electricity: null,
              kcal: null,
              money: null,
              time: null,
              showPersonalMessage: false,
              isTeam: false,
            ),
          ],
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
