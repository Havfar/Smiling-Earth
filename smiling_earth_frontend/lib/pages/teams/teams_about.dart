import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/challenge/challenge_cubit.dart';
import 'package:smiling_earth_frontend/cubit/challenge/leave_challenge_cubit.dart';
import 'package:smiling_earth_frontend/cubit/teams/detailed_team_cubit.dart';
import 'package:smiling_earth_frontend/cubit/teams/teams_cubit.dart';
import 'package:smiling_earth_frontend/models/teams.dart';
import 'package:smiling_earth_frontend/pages/challenges/challenge_detailed.dart';
import 'package:smiling_earth_frontend/pages/not_implemented.dart';
import 'package:smiling_earth_frontend/pages/teams/team_rivalries.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_challenges.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_detailed.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_page.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_posts.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_rival_requests.dart';
import 'package:smiling_earth_frontend/widgets/circle_icon.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

class TeamAbout extends StatelessWidget {
  final int? teamId;
  TeamAbout({required this.teamId});

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        // builder: (BuildContext context) => TeamsDetailedPage(id: id),
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              TeamsDetailedPage(id: teamId),
          transitionDuration: Duration.zero,
        ));
        break;
      case 1:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              TeamPosts(id: teamId),
          transitionDuration: Duration.zero,
        ));
        break;
      case 2:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              TeamChallenges(teamId: teamId),
          transitionDuration: Duration.zero,
        ));
        break;
      case 3:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              TeamAbout(teamId: teamId),
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
      body: ListView(children: [
        BlocProvider(
          create: (context) => DetailedTeamCubit()..getTeams(teamId!),
          child: BlocBuilder<DetailedTeamCubit, DetailedTeamState>(
            builder: (context, state) {
              if (state is RetrievedTeam) {
                return Column(
                  children: [
                    SizedBox(height: 20),
                    _BuildTeamSettings(state.teams),
                    SizedBox(height: 20),
                    _BuildMembersSettings(),
                    SizedBox(height: 20),
                    _BuildRivalriesSettings(),
                    SizedBox(height: 20),
                    _BuildChallengesSettings(teamId!)
                  ],
                );
              }
              return Container(
                margin: EdgeInsets.only(top: 50),
                child: Center(
                    widthFactor: 1,
                    heightFactor: 1,
                    child: CircularProgressIndicator()),
              );
            },
          ),
        )
      ]),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 3,
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

class _BuildChallengesSettings extends StatelessWidget {
  final int teamId;
  const _BuildChallengesSettings(
    this.teamId, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 15),
          child: Text('Challenges',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        BlocProvider(
            create: (context) =>
                ChallengeCubit()..getJoinedTeamChallenges(teamId),
            child: BlocBuilder<ChallengeCubit, ChallengeState>(
                builder: (context, state) {
              if (state is RetrievedJoinedChallenges) {
                if (state.challenges.isEmpty) {
                  return Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Center(
                        child: Text(
                            "The team has not joined any challenges yet..")),
                  );
                }
                return Column(
                    children: state.challenges
                        .map(
                          (challenge) => Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: ListTile(
                                trailing: Container(
                                  child: BlocProvider(
                                    create: (context) => LeaveChallengeCubit(),
                                    child: BlocBuilder<LeaveChallengeCubit,
                                        LeaveChallengeState>(
                                      builder: (context, state) {
                                        if (state is LeaveChallengeLeft) {
                                          return Text('left');
                                        } else if (state
                                            is LeaveChallengeSending) {
                                          return CircularProgressIndicator();
                                        }
                                        return IconButton(
                                            onPressed: () => BlocProvider.of<
                                                        LeaveChallengeCubit>(
                                                    context)
                                                .leaveTeamChallenge(teamId,
                                                    challenge.challenge.id!),
                                            icon: Icon(Icons.delete,
                                                color: Colors.red));
                                      },
                                    ),
                                  ),
                                ),
                                title: Text(challenge.challenge.title),
                                leading: CircleIcon(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailedChallengesPage(
                                                  challengeId:
                                                      challenge.challenge.id!,
                                                  teamId: teamId,
                                                ))),
                                    backgroundColor: Colors.white,
                                    emoji: challenge.challenge.symbol)),
                          ),
                        )
                        .toList());
              } else if (state is RetrievedChallengesError) {
                return Text('Error: ' + state.error);
              }
              return Text('loading');
            }))
      ],
    );
  }
}

class _BuildRivalriesSettings extends StatelessWidget {
  const _BuildRivalriesSettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 15),
          child: Text('Rivalries',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
          child: ListTile(
            onTap: () => (Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation,
                      Animation<double> secondaryAnimation) =>
                  RivalriesPage(teamId: 1),
              transitionDuration: Duration.zero,
            ))),
            trailing: Icon(Icons.chevron_right),
            title: Text('Rivalries '),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
          child: ListTile(
            onTap: () => (Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation,
                      Animation<double> secondaryAnimation) =>
                  RivalryRequestsPage(teamId: 1),
              transitionDuration: Duration.zero,
            ))),
            trailing: Icon(Icons.chevron_right),
            title: Text('Rivalries Requests'),
          ),
        ),
      ],
    );
  }
}

class _BuildMembersSettings extends StatelessWidget {
  const _BuildMembersSettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 15),
          child: Text('Members',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
          child: ListTile(
            trailing: Icon(Icons.chevron_right),
            title: Text('Members (12) '),
            onTap: () => (Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation,
                      Animation<double> secondaryAnimation) =>
                  NotImplementedPage(),
              transitionDuration: Duration.zero,
            ))),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
          child: ListTile(
            onTap: () => (Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation,
                      Animation<double> secondaryAnimation) =>
                  NotImplementedPage(),
              transitionDuration: Duration.zero,
            ))),
            trailing: Icon(Icons.chevron_right),
            title: Text('Invite other to join the team'),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
          child: ListTile(
            trailing: Container(
              height: 35,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                  child:
                      Text('Leave team', style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    TeamsCubit().leaveTeam(1);
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) =>
                          TeamsPage(),
                      transitionDuration: Duration.zero,
                    ));
                  }),
            ),
            title: Text('Would you like to leave the team?'),
          ),
        ),
      ],
    );
  }
}

class _BuildTeamSettings extends StatelessWidget {
  final TeamDetailedDto team;
  const _BuildTeamSettings(
    this.team, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 15),
          child: Text('Team Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Container(
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey.shade200))),
            child: ListTile(
              title: Row(
                children: [
                  Container(width: 100, child: Text('Name: ')),
                  SizedBox(width: 30),
                  Text(team.name),
                ],
              ),
            )),
        // Container(
        //     decoration: BoxDecoration(
        //         border:
        //             Border(bottom: BorderSide(color: Colors.grey.shade200))),
        //     child: ListTile(
        //       title: Row(
        //         children: [
        //           Container(width: 100, child: Text('Team Admin: ')),
        //           SizedBox(width: 30),
        //           Text(team.),
        //         ],
        //       ),
        //     )),
        Container(
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey.shade200))),
            child: ListTile(
              title: Row(
                children: [
                  Container(width: 100, child: Text('Description: ')),
                  SizedBox(width: 30),
                  Container(
                      width: 220,
                      child: Text(
                          team.description == null ? '' : team.description!)),
                ],
              ),
            )),
      ],
    );
  }
}
