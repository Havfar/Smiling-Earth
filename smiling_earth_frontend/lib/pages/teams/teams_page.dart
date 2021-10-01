import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/teams/teams_cubit.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';
import 'package:smiling_earth_frontend/widgets/teams_widget.dart';

class TeamsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green),
        backgroundColor: Colors.white,
      ),
      drawer: NavigationDrawerWidget(),
      body: Container(
        margin: EdgeInsets.all(15),
        child: ListView(
          children: [
            BlocProvider(
              create: (context) => TeamsCubit()..getJoinedTeams(),
              child: BuildMyTeams(),
            ),
            BlocProvider(
              create: (context) => TeamsCubit()..getTeams(),
              child: BuildGetTeams(),
            ),
          ],
        ),
      ));
}

class BuildMyTeams extends StatelessWidget {
  const BuildMyTeams({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamsCubit, TeamsState>(
      builder: (context, state) {
        if (state is RetrievedTeams) {
          return Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Joined teams",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () => print("new"),
                      child: Text("Create a new team"))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: state.teams
                    .map(
                        (team) => TeamWidget(team: team, showJoinButton: false))
                    .toList(),
              )
            ],
          ));
        } else if (state is ErrorRetrievingTeams) {
          return Text("Error" + state.error);
        }
        return Text("Loading");
      },
    );
  }
}

class BuildGetTeams extends StatelessWidget {
  const BuildGetTeams({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamsCubit, TeamsState>(
      builder: (context, state) {
        if (state is RetrievedTeams) {
          return Container(
              margin: EdgeInsets.only(top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Other teams",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: state.teams
                        .map((team) =>
                            TeamWidget(team: team, showJoinButton: true))
                        .toList(),
                  )
                ],
              ));
        } else if (state is ErrorRetrievingTeams) {
          return Text("Error" + state.error);
        }
        return Text("Loading");
      },
    );
  }
}
