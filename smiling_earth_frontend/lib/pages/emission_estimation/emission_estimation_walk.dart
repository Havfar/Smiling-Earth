import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/pages/emission_estimation/emission_estimation.dart';
import 'package:smiling_earth_frontend/pages/emission_estimation/emission_estimation_cycling.dart';
import 'package:smiling_earth_frontend/pages/emission_estimation/emission_estimation_driving.dart';
import 'package:smiling_earth_frontend/pages/home/home_page.dart';

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
        child: Column(
          children: [BuildHeaderToolbar(), BuildWalkingEstimation()],
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('See how much you can save by walking instead of driving'),
        Row(
          children: [
            Column(children: [
              Icon(Icons.directions_walk),
              Text((_sliderValue * 100).roundToDouble().toString() + ' km')
            ]),
            Slider(
                value: _sliderValue,
                onChanged: (newValue) => setState(() {
                      _sliderValue = newValue;
                    })),
            Column(children: [
              Icon(Icons.directions_car),
              Text(
                  ((1 - _sliderValue) * 100).roundToDouble().toString() + ' km')
            ]),
          ],
        ),
        ListTile(
          leading: Text('💰', style: TextStyle(fontSize: 22)),
          title: Text('By walking you could save (per day): '),
          trailing: Text('100' + ' kr'),
        ),
        ListTile(
          leading: Text('⚡️', style: TextStyle(fontSize: 22)),
          title: Text('Your energy percentage from solar: '),
          trailing: Text('10' + ' %'),
        )
      ],
    );
  }
}

class BuildHeaderToolbar extends StatelessWidget {
  const BuildHeaderToolbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Walking",
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
              "123",
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
              "123",
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
              "123",
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
              "123",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "km",
              style: TextStyle(color: Colors.black87),
            )
          ],
        )
      ]),
    );
  }
}
