import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/models/energy.dart';
import 'package:smiling_earth_frontend/pages/emission_estimation/emission_estimation_cycling.dart';
import 'package:smiling_earth_frontend/pages/emission_estimation/emission_estimation_driving.dart';
import 'package:smiling_earth_frontend/pages/emission_estimation/emission_estimation_walk.dart';
import 'package:smiling_earth_frontend/pages/home/home_page.dart';

class EmissionEstimatePage extends StatefulWidget {
  @override
  _EmissionEstimatePageState createState() => _EmissionEstimatePageState();
}

class _EmissionEstimatePageState extends State<EmissionEstimatePage> {
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
                .push(MaterialPageRoute(builder: (context) => HomePage()))),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Column(
          children: [BuildHeaderToolbar(), BuildSolarEstimation()],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
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

class BuildSolarEstimation extends StatefulWidget {
  const BuildSolarEstimation({
    Key? key,
  }) : super(key: key);

  @override
  State<BuildSolarEstimation> createState() => _BuildSolarEstimationState();
}

class _BuildSolarEstimationState extends State<BuildSolarEstimation> {
  int selectedButton = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SolarPanelButton(
            panelSize: 3.0,
            isSelected: selectedButton == 0,
            changeActiveIndex: () => setActiveIntex(0),
          ),
          SizedBox(width: 10),
          SolarPanelButton(
            panelSize: 4.0,
            isSelected: selectedButton == 1,
            changeActiveIndex: () => setActiveIntex(1),
          ),
          SizedBox(width: 10),
          SolarPanelButton(
            panelSize: 5.0,
            isSelected: selectedButton == 2,
            changeActiveIndex: () => setActiveIntex(2),
          ),
          SizedBox(width: 10),
          SolarPanelButton(
            panelSize: 6.0,
            isSelected: selectedButton == 3,
            changeActiveIndex: () => setActiveIntex(3),
          ),
        ]),
        // BuildChart()
        ListTile(
          leading: Text('💰', style: TextStyle(fontSize: 22)),
          title: Text('By change to solar panel you could save (per day): '),
          trailing: Text(_calculateSavingsOfSolar().abs().toString() + ' kr'),
        ),
        ListTile(
          leading: Text('⚡️', style: TextStyle(fontSize: 22)),
          title: Text('Your energy percentage from solar: '),
          trailing: Text('10' + ' %'),
        )
      ],
    );
  }

  double _calculateSavingsOfSolar() {
    switch (selectedButton) {
      case 0:
        return Energy.calculateElectricityCostWithSolar(3);
      case 1:
        return Energy.calculateElectricityCostWithSolar(4);

      case 2:
        return Energy.calculateElectricityCostWithSolar(5);

      default:
        return Energy.calculateElectricityCostWithSolar(6);
    }
  }

  setActiveIntex(int index) => setState(() {
        print('jadda');
        selectedButton = index;
      });
}

class SolarPanelButton extends StatelessWidget {
  final double panelSize;
  final bool isSelected;
  final void Function() changeActiveIndex;

  const SolarPanelButton({
    Key? key,
    required this.panelSize,
    required this.isSelected,
    required this.changeActiveIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.changeActiveIndex,
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.white,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.grey.shade200)),
        child: Center(
            child: Text(panelSize.toString() + ' KW',
                style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold))),
      ),
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
