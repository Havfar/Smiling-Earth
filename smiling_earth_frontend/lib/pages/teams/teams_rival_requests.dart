import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/teams/rival_request_cubit.dart';
import 'package:smiling_earth_frontend/models/rivals.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_page.dart';
import 'package:smiling_earth_frontend/widgets/circle_icon.dart';

class RivalryRequestsPage extends StatelessWidget {
  final int teamId;

  const RivalryRequestsPage({Key? key, required this.teamId}) : super(key: key);
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
          children: [_BuildRequests(teamId)],
        ),
      );
}

class _BuildRequests extends StatelessWidget {
  final int teamId;
  const _BuildRequests(
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
          create: (context) => RivalRequestCubit()..getRequests(teamId),
          child: BlocBuilder<RivalRequestCubit, RivalRequestState>(
            builder: (context, state) {
              if (state is RivalRequestRetrived) {
                if (state.rivalRequests.isEmpty) {
                  return Center(child: Text('No request found'));
                }
                return Column(
                    children: state.rivalRequests.map((rivalry) {
                  if (rivalry.receiver.id == teamId) {
                    var team = rivalry.sender;
                    return Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey.shade200))),
                        child: ListTile(
                          leading: CircleIcon(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TeamsPage())),
                              backgroundColor: Colors.blue,
                              emoji: team.symbol),
                          title: Text(team.name),
                          trailing: Container(
                            width: 200,
                            child: BlocProvider(
                              create: (context) => RivalRequestCubit(),
                              child: BlocBuilder<RivalRequestCubit,
                                  RivalRequestState>(
                                builder: (context, state) {
                                  if (state is RivalRequestAccepted) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('Accepted'),
                                      ],
                                    );
                                  } else if (state is RivalRequestDeclined) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('Declined'),
                                      ],
                                    );
                                  }
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          color: Colors.green,
                                          onPressed: () => BlocProvider.of<
                                                  RivalRequestCubit>(context)
                                              .acceptRivalryRequests(RivalDto(
                                                  rivalry.id,
                                                  rivalry.sender,
                                                  rivalry.receiver,
                                                  'a')),
                                          icon: Icon(Icons.check)),
                                      SizedBox(width: 10),
                                      IconButton(
                                          color: Colors.grey,
                                          onPressed: () => BlocProvider.of<
                                                  RivalRequestCubit>(context)
                                              .declineRivalryRequests(rivalry),
                                          icon: Icon(Icons.delete))
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ));
                  }

                  //              BlocBuilder<JoinTeamCubit, JoinTeamState>(
                  //   builder: (context, state) {
                  //     if (state is TeamJoined) {
                  //       return ElevatedButton(
                  //           onPressed: () {
                  //             Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) => TeamsDetailedPage(id: team.id)),
                  //             ); // push it back in
                  //           },
                  //           child: Text('Go to team'));
                  //     } else if (state is TeamJoinedError) {
                  //       return Text("Error" + state.error);
                  //     } else if (state is JoiningTeam) {
                  //       return CircularProgressIndicator();
                  //     }
                  //     return ElevatedButton(
                  //         onPressed: () {
                  //           BlocProvider.of<JoinTeamCubit>(context).joinTeam(team.id!);
                  //         },
                  //         child: Text('Join'));
                  //     // return Text("");
                  //   },
                  // )
                  var team = rivalry.receiver;
                  return Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey.shade200))),
                      child: ListTile(
                          leading: CircleIcon(
                              onTap: null,
                              backgroundColor: Colors.blue,
                              emoji: team.symbol),
                          title: Text(team.name),
                          trailing: Container(
                              width: 110,
                              child: Text('Waiting for team to respond..'))));
                }).toList());
              }
              return Text('Loading');
            },
          ),
        )
      ],
    );
  }
}
