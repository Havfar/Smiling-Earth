import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/utils/services/activity_recognition.dart';
import 'package:smiling_earth_frontend/widgets/emission_chart.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(new SmilingEarthHome());
}

class SmilingEarthHome extends StatefulWidget {
  @override
  _SmilingEarthHomeState createState() => new _SmilingEarthHomeState();
}

class _SmilingEarthHomeState extends State<SmilingEarthHome> {
  @override
  void initState() {
    super.initState();
    startActivityMonitor();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
      //drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('Main'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      drawer: NavigationDrawerWidget(),
      body: Container(
        height: 800,
        margin: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            buildHeaderToolbar(),
            buildChart(),
            buildEmissionEstimation(),
            buildFeed(),
            // Container(
            //   height: 300,
            //   color: Colors.yellowAccent,
            //   child: Text("Box 4"),
            // )
          ],
        ),
      ),
    ));
  }
}

class buildChart extends StatelessWidget {
  const buildChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'One';

    return Container(
      child: Column(children: [
        Row(
          children: [
            Text("Emissions",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                )),
          ],
        ),
        Center(
          child: SmilingEarthEmissionChart(
            energyEmissionPercentage: 0.15,
            transportEmissionPercentage: 0.33,
          ),
        ),
        Text("134 kg Co2",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            )),
      ]),
    );
  }
}

class buildFeed extends StatelessWidget {
  const buildFeed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.purpleAccent,
      child: Column(children: [
        Row(children: [Text("Title")]),
        Column(children: [
          Container(
            color: Colors.cyanAccent,
            child: Text("Feed"),
          )
        ])
      ]),
    );
  }
}

class buildEmissionEstimation extends StatelessWidget {
  const buildEmissionEstimation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.amber,
      child: Text("Emission estimation"),
    );
  }
}

class buildHeaderToolbar extends StatelessWidget {
  const buildHeaderToolbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.amber,
      child: Text("Header"),
    );
  }
}
