import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

class LeaderboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Leaderboard'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        drawer: NavigationDrawerWidget(),
      );
}
