import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/challenge/challenge_cubit.dart';
import 'package:smiling_earth_frontend/cubit/challenge/join_challenge_cubit.dart';
import 'package:smiling_earth_frontend/models/challenge.dart';
import 'package:smiling_earth_frontend/pages/challenges/challenge_detailed.dart';
import 'package:smiling_earth_frontend/widgets/circle_icon.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

class PreviewChallengesPage extends StatelessWidget {
  final int id;

  const PreviewChallengesPage({Key? key, required this.id}) : super(key: key);
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
              child: _BuildDetailed()),
          BlocProvider(
            create: (context) => JoinChallengeCubit(),
            child: _BuildJoinButton(this.id),
          )
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
            ],
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class _BuildJoinButton extends StatelessWidget {
  final int id;
  const _BuildJoinButton(
    this.id, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JoinChallengeCubit, JoinChallengeState>(
      builder: (context, state) {
        if (state is JoiningChallenge) {
          return CircularProgressIndicator();
        } else if (state is ChallengeJoined) {
          return Column(
            children: [
              Text('You have now joined the challenge'),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailedChallengesPage(id: this.id)),
                    ); // push it back in
                  },
                  child: Text('Go to Challenge'))
            ],
          );
        } else if (state is ChallengeJoinedError) {
          return Text('Error' + state.error);
        }
        return ElevatedButton(
          child: Text('Join'),
          onPressed: () {
            BlocProvider.of<JoinChallengeCubit>(context).joinChallenge(this.id);
          },
        );
      },
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
