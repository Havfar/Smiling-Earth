import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/challenge/challenge_cubit.dart';
import 'package:smiling_earth_frontend/models/challenge.dart';
import 'package:smiling_earth_frontend/widgets/circle_icon.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

class DetailedChallengesPage extends StatelessWidget {
  final int id;

  const DetailedChallengesPage({Key? key, required this.id}) : super(key: key);
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
                  ChallengeCubit()..getDetailedChallenge(this.id),
              child: _BuildDetailed())
        ]),
      ));
}

class _BuildDetailed extends StatelessWidget {
  const _BuildDetailed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChallengeCubit, ChallengeState>(
      builder: (context, state) {
        if (state is RetrievedDetailedChallenge) {
          return Column(
            children: [
              _BuildHeader(state.challenge),
              _BuildProgressBar(progress: 12, goal: 20),
              _BuildLeaderboard(state.challenge.leaderboard)
            ],
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class _BuildProgressBar extends StatelessWidget {
  final int progress;
  final int goal;
  const _BuildProgressBar({required this.progress, required this.goal});

  @override
  Widget build(BuildContext context) {
    double percent = this.progress / this.goal;
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
                child: LinearProgressIndicator(value: percent),
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
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleIcon(
                  backgroundColor: Colors.blueAccent,
                  emoji: this.challenge.symbol),
              SizedBox(width: 20),
              Text(this.challenge.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(height: 20),
          Row(children: [
            Icon(Icons.calendar_today_outlined),
            Text("17. oct - 17.may")
          ]),
          Row(children: [
            Icon(Icons.flag_outlined),
            Text("Commute 20 days by using a zero emissions vehicle")
          ]),
          SizedBox(height: 20),
          Text(this.challenge.description),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _BuildLeaderboard extends StatelessWidget {
  final List<UserChallengeDto> leaderboard;
  const _BuildLeaderboard(
    this.leaderboard, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50, right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Leader board',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              )),
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
              children: this
                  .leaderboard
                  .map((score) => Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black12))),
                        child: ListTile(
                            leading: Text(score.id.toString()),
                            title: Text(score.user.getName()),
                            trailing: Text(score.score.toString())),
                      ))
                  .toList())
        ],
      ),
    );
  }
}
