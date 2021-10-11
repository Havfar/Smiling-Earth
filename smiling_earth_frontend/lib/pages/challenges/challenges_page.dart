import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/challenge/challenge_cubit.dart';
import 'package:smiling_earth_frontend/models/challenge.dart';
import 'package:smiling_earth_frontend/pages/challenges/challenge_detailed.dart';
import 'package:smiling_earth_frontend/pages/challenges/challenges_preview.dart';
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
              create: (context) => ChallengeCubit()..getJoinedChallenges(),
              child: _BuildJoinedChallenges(),
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

class _BuildJoinedChallenges extends StatelessWidget {
  const _BuildJoinedChallenges({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My challenges",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10),
        BlocBuilder<ChallengeCubit, ChallengeState>(
          builder: (context, state) {
            if (state is RetrievedJoinedChallenges) {
              return Column(
                  children: state.challenges
                      .map((challenge) => ChallengeJoinedWidget(challenge,
                          showJoinButton: false))
                      .toList());
            } else if (state is RetrievedChallengesError) {
              return Text('Error: ' + state.error);
            }
            return CircularProgressIndicator();
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
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10),
        BlocBuilder<ChallengeCubit, ChallengeState>(
          builder: (context, state) {
            if (state is RetrievedChallenges) {
              return Column(
                children: state.challenges
                    .map((challenge) => ChallengeWidget(challenge))
                    .toList(),
              );
            } else if (state is RetrievedChallengesError) {
              return Text('Error: ' + state.error);
            }
            return CircularProgressIndicator();
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
                        Text(
                          this.challenge.challenge.title,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "2 weeks and 5 days left",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w300),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: 250,
                              height: 10,
                              // margin: EdgeInsets.only(top: 10),
                              child: LinearProgressIndicator(
                                  value: double.tryParse("0.3")),
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

class ChallengeWidget extends StatelessWidget {
  final ChallengeDto challenge;
  const ChallengeWidget(this.challenge, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PreviewChallengesPage(id: this.challenge.id!)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  CircleIcon(
                    emoji: challenge.symbol,
                    backgroundColor: Colors.blueGrey,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          challenge.title,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "2 weeks and 5 days left",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(top: 5, right: 10),
                    child: TextButton(
                      onPressed: () => print("joined"),
                      child:
                          Text("Join", style: TextStyle(color: Colors.white)),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blueAccent),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
