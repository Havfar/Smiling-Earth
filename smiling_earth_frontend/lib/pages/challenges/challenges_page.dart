import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:smiling_earth_frontend/cubit/challenge/challenge_cubit.dart';
import 'package:smiling_earth_frontend/models/challenge.dart';
import 'package:smiling_earth_frontend/pages/challenges/challenge_detailed.dart';
import 'package:smiling_earth_frontend/utils/challenges_util.dart';
import 'package:smiling_earth_frontend/utils/string_utils.dart';
import 'package:smiling_earth_frontend/widgets/challenge_widget.dart';
import 'package:smiling_earth_frontend/widgets/circle_icon.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

class ChallengesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.green),
          backgroundColor: Colors.white,
        ),
        drawer: NavigationDrawerWidget(),
        body: Container(
          margin: EdgeInsets.all(15),
          child: ListView(children: [
            BlocProvider(
              create: (context) => ChallengeCubit()..getMyCompletedChallenges(),
              child: BuildCompletedChallenges(),
            ),
            IconButton(
                onPressed: () => ChallengesUtil().updateChallenges(),
                icon: Icon(Icons.sync)),
            SizedBox(height: 30),
            BlocProvider(
              create: (context) => ChallengeCubit()..getJoinedChallenges(),
              child: BuildJoinedChallenges(),
            ),
            SizedBox(height: 30),
            BlocProvider(
              create: (context) => ChallengeCubit()..getChallenges(),
              child: _BuildChallenges(),
            ),
          ]),
        ),
      );
}

class BuildJoinedChallenges extends StatelessWidget {
  const BuildJoinedChallenges({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Joined challenges",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10),
        BlocBuilder<ChallengeCubit, ChallengeState>(
          builder: (context, state) {
            if (state is RetrievedJoinedChallenges) {
              if (state.challenges.isEmpty) {
                return Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Center(
                      child: Text("You have not joined any challenges yet..")),
                );
              }
              return Column(
                  children: state.challenges
                      .map((challenge) => ChallengeJoinedWidget(challenge,
                          showJoinButton: false))
                      .toList());
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

class _BuildChallenges extends StatelessWidget {
  const _BuildChallenges({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "New challenges",
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
                      child: Text("You have joined all the challenges! 🏆💪")),
                );
              }
              return Column(
                children: state.challenges
                    .map((challenge) => ChallengeWidget(challenge))
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

class BuildCompletedChallenges extends StatelessWidget {
  const BuildCompletedChallenges({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Completed challenges",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10),
        BlocBuilder<ChallengeCubit, ChallengeState>(
          builder: (context, state) {
            print(state);
            if (state is RetrievedChallenges) {
              if (state.challenges.isEmpty) {
                return Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 30),
                  child:
                      Center(child: Text("Not completed any challenges yet")),
                );
              }
              return Row(
                children: state.challenges
                    .map((challenge) => Container(
                          margin: EdgeInsets.only(right: 15),
                          child: Column(
                            children: [
                              CircleIcon(
                                  backgroundColor: Colors.amber,
                                  emoji: challenge.symbol),
                              Container(
                                  width: 90,
                                  child: Text(
                                    truncate(challenge.title, 23),
                                    textAlign: TextAlign.center,
                                  ))
                            ],
                          ),
                        ))
                    .toList(),
              );
            } else if (state is RetrievedChallengesError) {
              return Text('Error: ' + state.error);
            }
            return SkeletonAnimation(
                // borderRadius: BorderRadius.circular(10.0),
                shimmerColor: Colors.white38,
                shimmerDuration: 4000,
                child: CircleIconSkeleton());
          },
        ),
      ],
    );
  }
}

class ChallengeJoinedWidget extends StatelessWidget {
  final bool showJoinButton;
  final JoinedChallengeDto challenge;
  const ChallengeJoinedWidget(this.challenge,
      {Key? key, required this.showJoinButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailedChallengesPage(id: challenge.challenge.id!)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(children: [
                Row(
                  children: [
                    CircleIcon(
                      emoji: this.challenge.challenge.symbol,
                      backgroundColor: Colors.greenAccent,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 200,
                          child: Text(
                            this.challenge.challenge.title,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                        // Text(
                        //   "2 weeks and 5 days left",
                        //   style: TextStyle(
                        //       fontSize: 12, fontWeight: FontWeight.w300),
                        // ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: 250,
                              height: 10,
                              // margin: EdgeInsets.only(top: 10),
                              child: LinearProgressIndicator(
                                  value: challenge.calulateProgress()),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
