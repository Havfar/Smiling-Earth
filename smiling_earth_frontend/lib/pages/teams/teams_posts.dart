import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_about.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_challenges.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_detailed.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

class TeamPosts extends StatelessWidget {
  final int? id;
  TeamPosts({required this.id});

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        // builder: (BuildContext context) => TeamsDetailedPage(id: id),
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              TeamsDetailedPage(id: id),
          transitionDuration: Duration.zero,
        ));
        break;
      case 1:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              TeamPosts(id: id),
          transitionDuration: Duration.zero,
        ));
        break;
      case 2:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              TeamChallenges(id: id),
          transitionDuration: Duration.zero,
        ));
        break;
      case 3:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              TeamAbout(id: id),
          transitionDuration: Duration.zero,
        ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green),
      ),
      drawer: NavigationDrawerWidget(),
      body: Text("Page"),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
          type: BottomNavigationBarType.fixed,
          onTap: (
            index,
          ) =>
              _onTap(context, index),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Emissions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.forum_outlined),
              label: 'Posts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events_outlined),
              label: 'Challenges',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'About',
            ),
          ]));
}
