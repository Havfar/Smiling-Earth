import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';
import 'package:smiling_earth_frontend/widgets/teams_widget.dart';

class TeamsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      drawer: NavigationDrawerWidget(),
      body: Container(
        margin: EdgeInsets.all(15),
        child: ListView(
          children: [
            buildMyTeams(),
            buildGetTeams(),
          ],
        ),
      ));
}

class buildMyTeams extends StatelessWidget {
  const buildMyTeams({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Joined teams",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
                onPressed: () => print("new"), child: Text("Create a new team"))
          ],
        ),
        SizedBox(
          height: 20,
        ),
        teamWidget(showJoinButton: false),
        teamWidget(showJoinButton: false),
        teamWidget(showJoinButton: false),
      ],
    ));
  }
}

class buildGetTeams extends StatelessWidget {
  const buildGetTeams({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Other teams",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            teamWidget(showJoinButton: true),
            teamWidget(showJoinButton: true),
            teamWidget(showJoinButton: true)
          ],
        ));
  }
}
