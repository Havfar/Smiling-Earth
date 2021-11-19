import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/teams/teams_cubit.dart';
import 'package:smiling_earth_frontend/models/teams.dart';
import 'package:smiling_earth_frontend/pages/registration/car_registration.dart';
import 'package:smiling_earth_frontend/pages/registration/climate_action.dart';
import 'package:smiling_earth_frontend/widgets/circle_icon.dart';
import 'package:smiling_earth_frontend/widgets/page_indicator.dart';

class TeamRegistrationPage extends StatelessWidget {
  const TeamRegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Text(
                'Teams',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20),
              Text(
                  'One of the things this application wants to understand is how adding online communities could enhance the system.\nTherby we indroduce "Teams". In a team you can compare your carbon emission with the other members and look at the team\'s combined carbon emissions. \nYou can also discuss with the other team members, join team challenges and compare the teams emissions to other rivaling teams'),
              SizedBox(height: 20),
              Text(
                'You are a member of:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              BlocProvider(
                create: (context) => TeamsCubit()..getJoinedTeams(),
                child: BuildMyTeams(),
              ),
              SizedBox(height: 20),
              Text(
                'There are many different teams to join. The teams can be manage on the "Teams" page in the navigation menu.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        bottomNavigationBar: PageIndicator(
            index: 8,
            previousPage:
                MaterialPageRoute(builder: (context) => CarRegistrationPage()),
            nextPage: MaterialPageRoute(
              builder: (context) => ClimateActionPage(),
            ),
            formSumbissionFunction: null),
      );
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
          if (state.teams.isEmpty) {
            return Center(
                child: Text(
                    'You are not registered to a team. You can join a team on the "Teams"-page'));
          }
          return Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children:
                    state.teams.map((team) => TeamWidget(team: team)).toList(),
              )
            ],
          ));
        } else if (state is ErrorRetrievingTeams) {
          return Text("Error" + state.error);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class TeamWidget extends StatelessWidget {
  final TeamsDto team;
  const TeamWidget({Key? key, required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(children: [
              Row(
                children: [
                  CircleIcon(
                    onTap: null,
                    emoji: team.symbol,
                    backgroundColor: Colors.blueAccent.shade100,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    this.team.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
