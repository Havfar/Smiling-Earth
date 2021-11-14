import 'package:flutter/material.dart';

class BuildHeaderToolbar extends StatelessWidget {
  final int? kcal;
  final int? time;
  final int? money;
  final int? distance;
  final int? electricity;
  final bool showPersonalMessage;
  final bool isTeam;

  const BuildHeaderToolbar(
      {Key? key,
      required this.kcal,
      required this.time,
      required this.money,
      required this.distance,
      required this.electricity,
      required this.showPersonalMessage,
      required this.isTeam})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          BuildGreeting(showPersonalMessage),

          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Burned🔥',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  kcal != null ? '$kcal kcal ' : '-',
                  style: TextStyle(fontSize: 16),
                ),
                // Text(
                //   "kcal",
                //   style: TextStyle(color: Colors.black87),
                // )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Moved 🚶‍♂️🚴',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  time != null ? '$time min' : '-',
                  style: TextStyle(fontSize: 16),
                ),
                // Text(
                //   "min",
                //   style: TextStyle(color: Colors.black87),
                // )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Saved 💰',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  money != null ? '$money kr' : '-',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                // Text(
                //   "kr",
                //   style: TextStyle(color: Colors.black87),
                // )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Used ⚡️',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  electricity != null ? '$electricity kWh' : '-',
                  style: TextStyle(fontSize: 16),
                ),
                // Container(
                //   width: 50,
                //   child: Text(
                //     "on heating",
                //     textAlign: TextAlign.center,
                //     style: TextStyle(color: Colors.black87, fontSize: 12),
                //   ),
                // )
              ],
            )
          ]),
          // Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          //   Text('This week you have',
          //       style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal))
          // ])
        ],
      ),
    );
  }
}

class BuildGreeting extends StatelessWidget {
  final bool showMessage;
  const BuildGreeting(
    this.showMessage, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (showMessage) {
      return Container(
        margin: EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // width: 250,
              child: Text(_getTimeGreeting(),
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ),
            Text('This week you have:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
            SizedBox(height: 20),
          ],
        ),
      );
    }
    return Container();
  }

  String _getTimeGreeting() {
    DateTime time = DateTime.now();
    String greeting = '';
    if (time.hour > 22) {
      greeting = 'Good Night 😴';
    } else if (time.hour > 18) {
      greeting = 'Good Evening 🌝';
    } else if (time.hour > 12) {
      greeting = 'Good Day! 👋';
    } else {
      greeting = 'Good Morning 🌞';
    }
    return greeting;
  }
}
