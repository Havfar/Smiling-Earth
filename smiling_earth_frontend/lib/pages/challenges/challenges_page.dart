import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/widgets/circle_icon.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

class ChallengesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.green),
          backgroundColor: Colors.white,
        ),
        drawer: NavigationDrawerWidget(),
        body: Container(
          margin: EdgeInsets.all(15),
          child: ListView(children: [
            _BuildJoinedChallenges(),
            SizedBox(height: 30),
            _BuildChallenges(),
          ]),
        ),
      );
}

class _BuildJoinedChallenges extends StatelessWidget {
  const _BuildJoinedChallenges({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My challenges",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10),
        ChallengeJoinedWidget(
          showJoinButton: false,
        ),
        ChallengeJoinedWidget(
          showJoinButton: false,
        ),
        ChallengeJoinedWidget(
          showJoinButton: false,
        ),
        ChallengeJoinedWidget(
          showJoinButton: false,
        ),
      ],
    );
  }
}

class _BuildChallenges extends StatelessWidget {
  const _BuildChallenges({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "New challenges",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10),
        ChallengeWidget(),
        ChallengeWidget(),
        ChallengeWidget(),
        ChallengeWidget(),
        ChallengeWidget(),
        ChallengeWidget(),
      ],
    );
  }
}

class ChallengeJoinedWidget extends StatelessWidget {
  final bool showJoinButton;
  const ChallengeJoinedWidget({Key? key, required this.showJoinButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => TeamsDetailedPage(id: team.id)),
          // );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(children: [
                Row(
                  children: [
                    CircleIcon(
                      emoji: "🏆",
                      backgroundColor: Colors.greenAccent,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Complete something for 10 days",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "2 weeks and 5 days left",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w300),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: 250,
                              height: 10,
                              // margin: EdgeInsets.only(top: 10),
                              child: LinearProgressIndicator(
                                  value: double.tryParse("0.3")),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

class ChallengeWidget extends StatelessWidget {
  const ChallengeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => TeamsDetailedPage(id: team.id)),
          // );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  CircleIcon(
                    emoji: "🏅",
                    backgroundColor: Colors.blueGrey,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Complete something for 10 days",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "2 weeks and 5 days left",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(top: 5, right: 10),
                    child: TextButton(
                      onPressed: () => print("joined"),
                      child:
                          Text("Join", style: TextStyle(color: Colors.white)),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blueAccent),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
