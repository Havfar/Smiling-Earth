import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/pages/home_page.dart';
import 'package:smiling_earth_frontend/pages/splash_page.dart';
import 'package:smiling_earth_frontend/utils/services/activity_recognition.dart';

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
    if (false) {
      return HomePage();
    } else {
      return MaterialApp(home: SplashPage());
    }
  }
}
