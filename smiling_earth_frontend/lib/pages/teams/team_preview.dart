import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/teams/detailed_team_cubit.dart';
import 'package:smiling_earth_frontend/cubit/teams/join_team_cubit.dart';
import 'package:smiling_earth_frontend/models/teams.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_detailed.dart';
import 'package:smiling_earth_frontend/widgets/circle_icon.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

class TeamPreview extends StatelessWidget {
  final int? id;
  TeamPreview({required this.id});
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green),
      ),
      drawer: NavigationDrawerWidget(),
      body: Container(
        child: BlocProvider(
            create: (context) => DetailedTeamCubit()..getTeams(this.id!),
            child: BlocBuilder<DetailedTeamCubit, DetailedTeamState>(
              builder: (context, state) {
                if (state is RetrievedTeam) {
                  return Center(
                      child: BlocProvider(
                    create: (context) => JoinTeamCubit(),
                    child: _BuildPreview(team: state.teams),
                  ));
                } else if (state is ErrorRetrievingTeam) {
                  return Text("Error " + state.error);
                }
                return LinearProgressIndicator();
              },
            )),
      ));
}

class _BuildPreview extends StatelessWidget {
  final TeamDetailedDto team;
  const _BuildPreview({
    Key? key,
    required this.team,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleIcon(backgroundColor: Colors.cyanAccent, emoji: this.team.symbol),
      BlocBuilder<JoinTeamCubit, JoinTeamState>(
        builder: (context, state) {
          if (state is TeamJoined) {
            return ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TeamsDetailedPage(id: team.id)),
                  ); // push it back in
                },
                child: Text('Go to team'));
          } else if (state is TeamJoinedError) {
            return Text("Error" + state.error);
          } else if (state is JoiningTeam) {
            return CircularProgressIndicator();
          }
          return ElevatedButton(
              onPressed: () {
                BlocProvider.of<JoinTeamCubit>(context).joinTeam(team.id!);
              },
              child: Text('Join'));
          // return Text("");
        },
      )
    ]);
  }
}
