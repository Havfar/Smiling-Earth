import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/models/transportation.dart';
import 'package:smiling_earth_frontend/pages/emission_estimation/emission_estimation.dart';
import 'package:smiling_earth_frontend/pages/emission_estimation/emission_estimation_cycling.dart';
import 'package:smiling_earth_frontend/pages/emission_estimation/emission_estimation_walk.dart';
import 'package:smiling_earth_frontend/pages/home/home_page.dart';
import 'package:smiling_earth_frontend/utils/services/activity_db_manager.dart';
import 'package:smiling_earth_frontend/widgets/emission_chart.dart';
import 'package:smiling_earth_frontend/widgets/emission_header.dart';

class DriveEmissionEstimatePage extends StatefulWidget {
  DriveEmissionEstimatePage({Key? key}) : super(key: key);

  @override
  _DriveEmissionEstimatePageState createState() =>
      _DriveEmissionEstimatePageState();
}

class _DriveEmissionEstimatePageState extends State<DriveEmissionEstimatePage> {
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
          children: [BuildElectricCarEstimation()],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 3,
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

class BuildElectricCarEstimation extends StatelessWidget {
  const BuildElectricCarEstimation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
        future: ActivityDatabaseManager.instance.getDurationDrivingPerDay(),
        builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text('Loading...'));
          }
          if (snapshot.data! == 0) {
            return Text('No car rides detected');
          }
          return Column(
            children: <Widget>[
              BuildHeaderToolbar(
                distance: snapshot.data!.round(),
                electricity: null,
                kcal: null,
                money: Transportation.compareCostElectricVsGasolineCar(
                        snapshot.data!)
                    .round(),
                time: null,
                showPersonalMessage: false,
                isTeam: false,
              ),
              Text('See how much you can save by changing to an electric car'),
              SmilingEarthEmissionChart(
                  hideTitle: true,
                  energyEmission: 10,
                  transportEmission: 20,
                  goal: 100),
              ListTile(
                leading: Text('🌳', style: TextStyle(fontSize: 22)),
                title: Text('By changing to an electric car you would save '),
                subtitle: Text('per day'),
                trailing: Text(Transportation.getGasolineCarEmissionByDistance(
                            snapshot.data!)
                        .roundToDouble()
                        .toString() +
                    ' kgCO2'),
              ),
              ListTile(
                leading: Text('💰', style: TextStyle(fontSize: 22)),
                title: Text('By changing to an electric car you would save: '),
                trailing: Text(Transportation.compareCostElectricVsGasolineCar(
                            snapshot.data!)
                        .roundToDouble()
                        .toString() +
                    ' kr'),
              )
            ],
          );
        });
  }
}
