import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_detailed.dart';
import 'package:smiling_earth_frontend/widgets/circle_icon.dart';

class teamWidget extends StatelessWidget {
  final String url =
      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80";
  final bool showJoinButton;
  const teamWidget({Key? key, required this.showJoinButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TeamsDetailedPage()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(children: [
                Row(
                  children: [
                    circleIcon(
                      emoji: "🌎",
                      backgroundColor: Colors.blueAccent.shade100,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Save the planet",
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
                  CircleAvatar(radius: 13, backgroundImage: NetworkImage(url)),
                  CircleAvatar(radius: 13, backgroundImage: NetworkImage(url)),
                  CircleAvatar(radius: 13, backgroundImage: NetworkImage(url)),
                  CircleAvatar(radius: 13, backgroundImage: NetworkImage(url)),
                  CircleAvatar(radius: 13, backgroundImage: NetworkImage(url)),
                  CircleAvatar(radius: 13, backgroundImage: NetworkImage(url)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(" has joined the team")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
