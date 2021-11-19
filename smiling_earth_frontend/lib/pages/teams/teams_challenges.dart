import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:smiling_earth_frontend/cubit/challenge/challenge_cubit.dart';
import 'package:smiling_earth_frontend/pages/challenges/challenges_page.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_about.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_detailed.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_posts.dart';
import 'package:smiling_earth_frontend/widgets/challenge_widget.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

class TeamChallenges extends StatelessWidget {
  final int teamId;
  TeamChallenges({required this.teamId});

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
              TeamPosts(teamId: teamId),
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
      body: ListView(
        children: [
          BlocProvider(
            create: (context) =>
                ChallengeCubit()..getCompletedTeamChallenges(teamId),
            child: BuildCompletedChallenges(),
          ),
          BlocProvider(
            create: (context) =>
                ChallengeCubit()..getJoinedTeamChallenges(teamId),
            child: BuildJoinedChallenges(teamId),
          ),
          BlocProvider(
            create: (context) => ChallengeCubit()..getTeamChallenges(teamId),
            child: _BuildChallenges(teamId: teamId),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 2,
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

class _BuildChallenges extends StatelessWidget {
  final int teamId;
  const _BuildChallenges({
    Key? key,
    required this.teamId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "New Team Challenges",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10),
        BlocBuilder<ChallengeCubit, ChallengeState>(
          builder: (context, state) {
            if (state is RetrievedChallenges) {
              if (state.challenges.isEmpty) {
                return Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Center(
                      child: Text(
                          "The team have joined all the challenges! 🏆💪")),
                );
              }
              return Column(
                children: state.challenges
                    .map((challenge) => ChallengeWidget(challenge, teamId))
                    .toList(),
              );
            } else if (state is RetrievedChallengesError) {
              return Text('Error: ' + state.error);
            }
            return SkeletonAnimation(
                // borderRadius: BorderRadius.circular(10.0),
                shimmerColor: Colors.white38,
                shimmerDuration: 4000,
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      ChallengeSkeletonWidget(),
                      SizedBox(width: 20),
                      ChallengeSkeletonWidget(),
                      SizedBox(width: 20),
                      ChallengeSkeletonWidget(),
                      SizedBox(width: 20),
                      ChallengeSkeletonWidget(),
                    ],
                  ),
                ));
          },
        ),
      ],
    );
  }
}
