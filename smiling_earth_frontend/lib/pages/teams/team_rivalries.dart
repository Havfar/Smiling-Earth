import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/teams/rival_request_cubit.dart';
import 'package:smiling_earth_frontend/cubit/teams/rivals_cubit.dart';
import 'package:smiling_earth_frontend/models/rivals.dart';
import 'package:smiling_earth_frontend/widgets/circle_icon.dart';

class RivalriesPage extends StatelessWidget {
  final int teamId;

  const RivalriesPage({Key? key, required this.teamId}) : super(key: key);
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
        // drawer: NavigationDrawerWidget(),
        body: ListView(
          children: [_BuildRivals(teamId), _BuildOtherRivals(teamId)],
        ),
      );
}

class _BuildOtherRivals extends StatelessWidget {
  final int teamId;

  const _BuildOtherRivals(
    this.teamId, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Challenge Other Teams',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        BlocProvider(
          create: (context) => RivalsCubit()..getOtherTeams(teamId),
          child: BlocBuilder<RivalsCubit, RivalsState>(
            builder: (context, state) {
              if (state is RivalsFetched) {
                if (state.rivals.isEmpty) {
                  return Center(child: Text('Could not find any teams'));
                }
                return Column(
                    children: state.rivals
                        .map((rival) => Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: ListTile(
                                title: Row(
                                  children: [
                                    CircleIcon(
                                        backgroundColor: Colors.blue,
                                        emoji: rival.symbol),
                                    SizedBox(width: 30),
                                    Text(rival.name),
                                  ],
                                ),
                                trailing: BlocProvider(
                                  create: (context) => RivalRequestCubit(),
                                  child: BlocBuilder<RivalRequestCubit,
                                      RivalRequestState>(
                                    builder: (context, state) {
                                      if (state is RivalRequestSent) {
                                        return Text('Sendt');
                                      } else if (state is RivalRequestLoading) {
                                        return CircularProgressIndicator();
                                      } else if (state is RivalRequestError) {
                                        return Text('An error occured');
                                      }
                                      return ElevatedButton(
                                          onPressed: () => BlocProvider.of<
                                                  RivalRequestCubit>(context)
                                              .sendRivalryRequests(
                                                  SimpleRivalDto(
                                                      teamId, rival.id!)),
                                          child: Text('Challenge'));
                                    },
                                  ),
                                ))))
                        .toList());
              }
              return Text('Loading');
            },
          ),
        )
      ],
    );
  }
}

class _BuildRivals extends StatelessWidget {
  final int teamId;
  const _BuildRivals(
    this.teamId, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Rivals",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        BlocProvider(
          create: (context) => RivalsCubit()..getRivals(teamId),
          child: BlocBuilder<RivalsCubit, RivalsState>(
            builder: (context, state) {
              if (state is RivalsFetched) {
                if (state.rivals.isEmpty) {
                  return Center(child: Text('No rivalries yet'));
                }
                return Column(
                    children: state.rivals
                        .map((team) => Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: ListTile(
                              title: Row(
                                children: [
                                  CircleIcon(
                                      backgroundColor: Colors.blue,
                                      emoji: team.symbol),
                                  SizedBox(width: 30),
                                  Text(team.name),
                                ],
                              ),
                            )))
                        .toList());
              }
              return Text('Loading');
            },
          ),
        )
      ],
    );
  }
}
