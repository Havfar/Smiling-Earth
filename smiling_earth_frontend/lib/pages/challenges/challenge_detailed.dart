import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/challenge/challenge_client.dart';
import 'package:smiling_earth_frontend/cubit/challenge/challenge_cubit.dart';
import 'package:smiling_earth_frontend/cubit/challenge/challenge_progress_cubit.dart';
import 'package:smiling_earth_frontend/models/challenge.dart';
import 'package:smiling_earth_frontend/pages/home/home_page.dart';
import 'package:smiling_earth_frontend/widgets/circle_icon.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

class DetailedChallengesPage extends StatelessWidget {
  final int challengeId;
  final int? teamId;

  const DetailedChallengesPage(
      {Key? key, required this.challengeId, required this.teamId})
      : super(key: key);
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
              create: (context) =>
                  ChallengeCubit()..getDetailedChallenge(this.challengeId),
              child: BlocBuilder<ChallengeCubit, ChallengeState>(
                builder: (context, state) {
                  if (state is RetrievedDetailedChallenge) {
                    return Column(
                      children: [
                        _BuildLeaveButton(state.challenge.isTeamChallenge,
                            state.challenge.id!),
                        _BuildHeader(state.challenge),
                        BlocProvider(
                          create: (context) {
                            if (state.challenge.isTeamChallenge) {
                              return ChallengeProgressCubit()
                                ..getTeamProgress(this.challengeId, teamId!);
                            }
                            return ChallengeProgressCubit()
                              ..getUserProgress(this.challengeId);
                          },
                          child: BlocBuilder<ChallengeProgressCubit,
                              ChallengeProgressState>(
                            builder: (context, state) {
                              if (state is RetrivedProgress) {
                                return _BuildProgressBar(
                                  progress: state.progress,
                                  goal: state.goal,
                                );
                              } else if (state is RetrivedProgressError) {
                                return Center(
                                  child: Text('Could not fetch progress'),
                                );
                              }
                              return Center(
                                child: Text('Loading'),
                              );
                            },
                          ),
                        ),
                        _BuildLeaderboard(state.challenge.leaderboard,
                            state.challenge.isTeamChallenge)
                      ],
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ))
        ]),
      ));
}

class _BuildLeaveButton extends StatelessWidget {
  final bool isTeamChallenge;
  final int challengeId;
  const _BuildLeaveButton(
    this.isTeamChallenge,
    this.challengeId, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.isTeamChallenge) {
      return SizedBox(height: 20);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 40,
          margin: EdgeInsets.only(top: 4, right: 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.red)),
          child: TextButton(
              onPressed: () {
                ChallengesClient().leaveChallenge(challengeId);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text(
                'leave',
                style: TextStyle(color: Colors.red),
              )),
        )
      ],
    );
  }
}

class _BuildProgressBar extends StatelessWidget {
  final int progress;
  final int goal;
  const _BuildProgressBar({required this.progress, required this.goal});

  @override
  Widget build(BuildContext context) {
    if (progress == null) {
      return SizedBox(height: 10);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Progress',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            )),
        Container(
            margin: EdgeInsets.only(top: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 350,
                height: 30,
                // margin: EdgeInsets.only(top: 10),
                child: LinearProgressIndicator(value: progress / goal),
              ),
            )),
      ],
    );
  }
}

class _BuildHeader extends StatelessWidget {
  final DetailedChallengeDto challenge;
  const _BuildHeader(
    this.challenge, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleIcon(
                  onTap: null,
                  backgroundColor: Colors.blueAccent,
                  emoji: this.challenge.symbol),
              SizedBox(width: 20),
              Container(
                width: 250,
                child: Text(this.challenge.title,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(this.challenge.description),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _BuildLeaderboard extends StatelessWidget {
  final List<dynamic> leaderboard;
  final bool isTeamChallenge;
  const _BuildLeaderboard(
    this.leaderboard,
    this.isTeamChallenge, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int counter = 0;

    return Container(
      margin: EdgeInsets.only(top: 50, right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Leaderboard',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  )),
              _buildHelpButton(
                isTeamChallenge: this.isTeamChallenge,
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12))),
            child: ListTile(
                dense: true,
                leading: Text('#'),
                title: Text('Name'),
                trailing: Text('Score')),
          ),
          Column(
              children: this.leaderboard.map((
            score,
          ) {
            counter++;
            return Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12))),
              child: ListTile(
                  leading: Text(counter.toString()),
                  title: Row(
                    children: [
                      Text(isTeamChallenge
                          ? score.team.name
                          : score.user.getName()),
                    ],
                  ),
                  trailing: Text(score.score.toString())),
            );
          }).toList())
        ],
      ),
    );
  }
}

class _buildHelpButton extends StatelessWidget {
  final bool isTeamChallenge;
  const _buildHelpButton({
    Key? key,
    required this.isTeamChallenge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isTeamChallenge) {
      return Container(
          child: IconButton(
              onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text('This component is not finished '),
                        content: const Text(
                            'Below you find an overview of how your team is doing in this challenge compared to the rivaling teams. Unfortunately, this was not completed in time'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      )),
              icon: Icon(Icons.help)));
    }
    return Container();
  }
}
