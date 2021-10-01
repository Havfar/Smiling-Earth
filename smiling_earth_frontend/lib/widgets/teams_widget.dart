import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/models/teams.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_detailed.dart';
import 'package:smiling_earth_frontend/widgets/circle_icon.dart';

class TeamWidget extends StatelessWidget {
  final String url =
      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80";
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
                builder: (context) => TeamsDetailedPage(id: team.id)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(children: [
                Row(
                  children: [
                    CircleIcon(
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
                          onPressed: () => print("joined"),
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
                  Text(this.team.memeberCount.toString() +
                      " people has joined the team")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
