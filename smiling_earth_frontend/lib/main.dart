import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/utils/services/activity_recognition.dart';
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
        child: ListView(
          children: [
            Container(
              height: 300,
              color: Colors.amber,
              child: Text("Box 1"),
            ),
            Container(
              height: 300,
              color: Colors.redAccent,
              child: Text("Box 2"),
            ),
            Container(
              height: 300,
              color: Colors.purpleAccent,
              child: Text("Box 3"),
            ),
            Container(
              height: 300,
              color: Colors.yellowAccent,
              child: Text("Box 4"),
            )
          ],
        ),
      ),
    ));
  }
}
