import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/models/challenge.dart';
import 'package:smiling_earth_frontend/pages/challenges/challenge_detailed.dart';
import 'package:smiling_earth_frontend/pages/challenges/challenges_preview.dart';
import 'package:smiling_earth_frontend/widgets/circle_icon.dart';

class ChallengeWidget extends StatelessWidget {
  final ChallengeDto challenge;
  final int? teamsId;
  const ChallengeWidget(this.challenge, this.teamsId, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PreviewChallengesPage(
                    id: this.challenge.id!, teamId: this.teamsId)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  CircleIcon(
                    onTap: null,
                    emoji: challenge.symbol,
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
                        Container(
                          width: 200,
                          child: Text(
                            challenge.title,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                        // Text(
                        //   "2 weeks and 5 days left",
                        //   style: TextStyle(
                        //       fontSize: 12, fontWeight: FontWeight.w300),
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(top: 5, right: 10),
                    child: TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PreviewChallengesPage(
                                id: this.challenge.id!, teamId: this.teamsId)),
                      ),
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

class ChallengeSkeletonWidget extends StatelessWidget {
  const ChallengeSkeletonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                CircleIconSkeleton(),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: 15,
                        width: 100,
                        decoration: BoxDecoration(color: Colors.grey.shade400)),
                    SizedBox(height: 10),
                    Container(
                        height: 10,
                        width: 180,
                        decoration: BoxDecoration(color: Colors.grey.shade400)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChallengeJoinedWidget extends StatelessWidget {
  final bool showJoinButton;
  final JoinedChallengeDto challenge;
  const ChallengeJoinedWidget(this.challenge,
      {Key? key, required this.showJoinButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailedChallengesPage(
                    challengeId: challenge.challenge.id!, teamId: null)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(children: [
                Row(
                  children: [
                    CircleIcon(
                      onTap: null,
                      emoji: this.challenge.challenge.symbol,
                      backgroundColor: Colors.greenAccent,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 200,
                          child: Text(
                            this.challenge.challenge.title,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                        // Text(
                        //   "2 weeks and 5 days left",
                        //   style: TextStyle(
                        //       fontSize: 12, fontWeight: FontWeight.w300),
                        // ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: 250,
                              height: 10,
                              // margin: EdgeInsets.only(top: 10),
                              child: LinearProgressIndicator(
                                  value: challenge.calulateProgress()),
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
