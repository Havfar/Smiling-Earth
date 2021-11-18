import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/models/teams.dart';
import 'package:smiling_earth_frontend/pages/teams/team_preview.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_detailed.dart';
import 'package:smiling_earth_frontend/widgets/circle_icon.dart';

class TeamWidget extends StatelessWidget {
  final bool showJoinButton;
  final TeamsDto team;
  const TeamWidget({Key? key, required this.showJoinButton, required this.team})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => this.showJoinButton
                      ? TeamPreview(id: team.id)
                      : TeamsDetailedPage(id: team.id!)));
        },
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(top: 5, right: 10),
                  child: showJoinButton
                      ? TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => this.showJoinButton
                                      ? TeamPreview(id: team.id)
                                      : TeamsDetailedPage(id: team.id!))),
                          child: Text("Join",
                              style: TextStyle(color: Colors.white)),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blueAccent),
                        )
                      : Text(""),
                )
              ]),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(this.team.membersCount.toString() +
                      " users has joined the team")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
