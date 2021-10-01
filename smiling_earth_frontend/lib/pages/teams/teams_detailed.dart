import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/teams/detailed_team_cubit.dart';
import 'package:smiling_earth_frontend/models/teams.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_about.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_challenges.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_posts.dart';
import 'package:smiling_earth_frontend/widgets/circle_icon.dart';
import 'package:smiling_earth_frontend/widgets/emission_chart.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

class TeamsDetailedPage extends StatelessWidget {
  final int? id;
  TeamsDetailedPage({required this.id});

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
      body: Container(
        child: BlocProvider(
          create: (context) => DetailedTeamCubit()..getTeams(this.id!),
          child: Container(
            child: BlocBuilder<DetailedTeamCubit, DetailedTeamState>(
              builder: (context, state) {
                if (state is RetrievedTeam) {
                  return ListView(children: [
                    buildPageHeader(team: state.teams),
                    SizedBox(height: 15),
                    buildPledges(),
                    SizedBox(height: 15),
                    buildChart(),
                    SizedBox(height: 15),
                    buildTeamScoreList(),
                    SizedBox(height: 15),
                    buildRivalryLeaderboard(),
                    SizedBox(height: 15),
                    buildTeamStats()
                  ]);
                } else if (state is ErrorRetrievingTeam) {
                  return Text("Error! " + state.error);
                }
                return Text("Loading");
              },
            ),
          ),
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

class buildPageHeader extends StatelessWidget {
  final TeamDetailedDto team;
  const buildPageHeader({
    Key? key,
    required this.team,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(this.team.name);
  }
}

class buildTeamStats extends StatelessWidget {
  const buildTeamStats({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Transportation"),
        Text("Total time of group members"),
        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black12))),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black12))),
                child: ListTile(
                  leading: Icon(Icons.directions_walk),
                  title: Text("Walking"),
                  subtitle: Text("Total time 2h 59 min"),
                  trailing: Text("0 kgCO2"),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black12))),
                child: ListTile(
                  leading: Icon(Icons.directions_car),
                  title: Text("Driving"),
                  subtitle: Text("Total time 2h 59 min"),
                  trailing: Text("65 kgCO2"),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black12))),
                child: ListTile(
                  leading: Icon(Icons.directions_train),
                  title: Text("Riding the train"),
                  subtitle: Text("Total time 45 min"),
                  trailing: Text("10 kgCO2"),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class buildTeamScoreList extends StatelessWidget {
  const buildTeamScoreList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Most Valuable Players"),
        Text("Top 3 team members with the lowest emissions"),
        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black12))),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black12))),
                child: ListTile(
                  leading: circleIcon(
                      backgroundColor: Colors.greenAccent, emoji: "🥗"),
                  title: Text("John Johnson"),
                  trailing: Text("65 kgCO2"),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class buildRivalryLeaderboard extends StatelessWidget {
  const buildRivalryLeaderboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Rivals"),
        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black12))),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black12))),
                child: ListTile(
                  leading: circleIcon(
                      backgroundColor: Colors.greenAccent, emoji: "🥗"),
                  title: Text("Team name"),
                  trailing: Text("65 kgCO2"),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class buildChart extends StatelessWidget {
  const buildChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

class buildPledges extends StatelessWidget {
  const buildPledges({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Pledges"),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Column(
                children: [
                  circleIcon(backgroundColor: Colors.redAccent, emoji: "😎"),
                  Text("pledge"),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Column(
                children: [
                  circleIcon(backgroundColor: Colors.redAccent, emoji: "😎"),
                  Text("pledge"),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Column(
                children: [
                  circleIcon(backgroundColor: Colors.redAccent, emoji: "😎"),
                  Text("pledge"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
