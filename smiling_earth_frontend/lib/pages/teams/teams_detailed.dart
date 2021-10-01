import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/teams/detailed_team_cubit.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_page.dart';

class TeamsDetailedPage extends StatelessWidget {
  final int? id;
  TeamsDetailedPage({required this.id});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TeamsPage(),
          )),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: BlocProvider(
          create: (context) => DetailedTeamCubit()..getTeams(this.id!),
          child: Container(
            child: BlocBuilder<DetailedTeamCubit, DetailedTeamState>(
              builder: (context, state) {
                if (state is RetrievedTeam) {
                  return Text(state.teams.name);
                } else if (state is ErrorRetrievingTeam) {
                  return Text("Error! " + state.error);
                }
                return Text("Loading");
              },
            ),
          ),
        ),
      ));
}
