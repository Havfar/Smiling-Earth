import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/pledge/pledge_cubit.dart';
import 'package:smiling_earth_frontend/cubit/teams/detailed_team_cubit.dart';
import 'package:smiling_earth_frontend/cubit/teams/rivals_cubit.dart';
import 'package:smiling_earth_frontend/models/avatar.dart';
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
              TeamAbout(teamId: id),
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
          child: ListView(children: [
        BlocProvider(
          create: (context) => DetailedTeamCubit()..getTeams(this.id!),
          child: BlocBuilder<DetailedTeamCubit, DetailedTeamState>(
            builder: (context, state) {
              if (state is RetrievedTeam) {
                return Column(
                  children: [
                    BuildPageHeader(team: state.teams),
                    BlocProvider(
                      create: (context) =>
                          DetailedTeamCubit()..getTeamEmission(this.id!),
                      child: BuildChart(state.teams),
                    ),
                  ],
                );
              } else if (state is ErrorRetrievingTeam) {
                return Text("Error " + state.error);
              }
              return LinearProgressIndicator();
            },
          ),
        ),
        SizedBox(height: 15),
        BlocProvider(
          create: (context) => PledgeCubit()..getTeamPledge(this.id!),
          child: BuildPledges(),
        ),
        SizedBox(height: 15),

        BlocProvider(
          create: (context) => DetailedTeamCubit()..getTeamMembers(this.id!),
          child: BuildTeamScoreList(),
        ),
        SizedBox(height: 15),
        BlocProvider(
          create: (context) => RivalsCubit()..getRivals(this.id!),
          child: BuildRivalryLeaderboard(this.id!),
        ),
        SizedBox(height: 15),
        // BuildTeamStats()
      ])),
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

class BuildPageHeader extends StatelessWidget {
  final TeamDetailedDto team;
  const BuildPageHeader({
    Key? key,
    required this.team,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Row(
        children: [
          CircleIcon(
              onTap: null,
              backgroundColor: Colors.blueAccent,
              emoji: this.team.symbol),
          SizedBox(width: 20),
          Text(this.team.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class BuildTeamStats extends StatelessWidget {
  const BuildTeamStats({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, bottom: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Transportation",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  )),
              Text("Total time of group members"),
            ],
          ),
        ),
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

class BuildTeamScoreList extends StatelessWidget {
  const BuildTeamScoreList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailedTeamCubit, DetailedTeamState>(
      builder: (context, state) {
        if (state is RetrieveTeamMembers) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Most Valuable Players",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        )),
                    Text("Top 3 team members with the lowest emissions"),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black12))),
                child: Column(
                    children: state
                        .getLeaderboard()
                        .map((member) => (Container(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(color: Colors.black12))),
                              child: ListTile(
                                  leading: Container(
                                      height: 60,
                                      width: 60,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Avatar.toSvg(member.user.avatar)),
                                  title: Text(member.user.getName()),
                                  trailing: Text(member.emissions.toString())),
                            )))
                        .toList()),
              )
            ],
          );
        } else if (state is ErrorRetrievingTeam) {
          return Text("Error " + state.error);
        }
        return Text("Loading");
      },
    );
  }
}

class BuildRivalryLeaderboard extends StatelessWidget {
  final int id;
  const BuildRivalryLeaderboard(
    this.id, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<RivalsCubit, RivalsState>(
          builder: (context, state) {
            if (state is RivalsFetched) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Rivals",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            )),
                      ],
                    ),
                  ),
                  Column(
                      children: state.rivals
                          .map((rival) => rivalListItem(rival, id))
                          .toList()),
                ],
              );
            } else if (state is RivalsError) {
              return Text("Error: " + state.error);
            }
            return Text("Loading");
          },
        ),
      ],
    );
  }

  Container rivalListItem(TeamsDto rivalTeam, int id) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration:
          BoxDecoration(border: Border(top: BorderSide(color: Colors.black12))),
      child: ListTile(
        leading: CircleIcon(
            onTap: null,
            backgroundColor: Colors.greenAccent,
            emoji: rivalTeam.symbol),
        title: Text(rivalTeam.name),
        trailing: Text(rivalTeam.emissions.toString() + " kgCO2"),
      ),
    );
  }
}

class BuildChart extends StatelessWidget {
  final TeamDetailedDto team;
  const BuildChart(
    this.team, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double goal = 1000.0;
    return Container(
      margin: EdgeInsets.only(left: 15),
      child: BlocBuilder<DetailedTeamCubit, DetailedTeamState>(
        builder: (context, state) {
          if (state is RetrievedTeamEmission) {
            return Column(children: [
              Row(
                children: [
                  Text("Emissions",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
              Center(
                child: SmilingEarthEmissionChart(
                    hideTitle: true,
                    energyEmission: state.energyEmission.toDouble(),
                    transportEmission: state.transportEmission.toDouble(),
                    goal: 100),
              )
            ]);
          }
          return Text('loading');
        },
      ),
    );
  }
}

class BuildPledges extends StatelessWidget {
  const BuildPledges({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("We pledges to:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
          SizedBox(height: 10),
          BlocBuilder<PledgeCubit, PledgeState>(builder: (context, state) {
            if (state is RetrievedPledges) {
              return Row(
                  children: state.pledges
                      .map((pledge) => Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Column(children: [
                            CircleIcon(
                                onTap: null,
                                backgroundColor: Colors.amberAccent,
                                emoji: pledge.icon),
                            Text(pledge.title),
                          ])))
                      .toList());
            }
            return Text("Loading");
          }),
        ],
      ),
    );
  }
}
