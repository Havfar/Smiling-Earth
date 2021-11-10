import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/cubit/teams/teams_cubit.dart';
import 'package:smiling_earth_frontend/pages/not_implemented.dart';
import 'package:smiling_earth_frontend/pages/teams/team_rivalries.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_challenges.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_detailed.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_page.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_posts.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_rival_requests.dart';
import 'package:smiling_earth_frontend/widgets/circle_icon.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

class TeamAbout extends StatelessWidget {
  final int? id;
  TeamAbout({required this.id});

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        // builder: (BuildContext context) => TeamsDetailedPage(id: id),
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              TeamsDetailedPage(id: id),
          transitionDuration: Duration.zero,
        ));
        break;
      case 1:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              TeamPosts(id: id),
          transitionDuration: Duration.zero,
        ));
        break;
      case 2:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              TeamChallenges(id: id),
          transitionDuration: Duration.zero,
        ));
        break;
      case 3:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              TeamAbout(id: id),
          transitionDuration: Duration.zero,
        ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green),
      ),
      drawer: NavigationDrawerWidget(),
      body: ListView(
        children: [
          SizedBox(height: 20),
          _BuildTeamSettings(),
          SizedBox(height: 20),
          _BuildMembersSettings(),
          SizedBox(height: 20),
          _BuildRivalriesSettings(),
          SizedBox(height: 20),
          _BuildChallengesSettings()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 3,
          type: BottomNavigationBarType.fixed,
          onTap: (
            index,
          ) =>
              _onTap(context, index),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Emissions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.forum_outlined),
              label: 'Posts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events_outlined),
              label: 'Challenges',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'About',
            ),
          ]));
}

class _BuildChallengesSettings extends StatelessWidget {
  const _BuildChallengesSettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 15),
          child: Text('Challenges',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
          child: ListTile(
              trailing: IconButton(
                  onPressed: () => (print('ok')
                      // ChallengesClient().leaveChallenge(challengeId)
                      ),
                  icon: Icon(Icons.delete, color: Colors.red)),
              title: Text('Rivalries Requests'),
              leading: CircleIcon(backgroundColor: Colors.white, emoji: 'ok')),
        ),
      ],
    );
  }
}

class _BuildRivalriesSettings extends StatelessWidget {
  const _BuildRivalriesSettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 15),
          child: Text('Rivalries',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
          child: ListTile(
            onTap: () => (Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation,
                      Animation<double> secondaryAnimation) =>
                  RivalriesPage(teamId: 1),
              transitionDuration: Duration.zero,
            ))),
            trailing: Icon(Icons.chevron_right),
            title: Text('Rivalries '),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
          child: ListTile(
            onTap: () => (Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation,
                      Animation<double> secondaryAnimation) =>
                  RivalryRequestsPage(teamId: 1),
              transitionDuration: Duration.zero,
            ))),
            trailing: Icon(Icons.chevron_right),
            title: Text('Rivalries Requests'),
          ),
        ),
      ],
    );
  }
}

class _BuildMembersSettings extends StatelessWidget {
  const _BuildMembersSettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 15),
          child: Text('Members',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
          child: ListTile(
            trailing: Icon(Icons.chevron_right),
            title: Text('Members (12) '),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
          child: ListTile(
            onTap: () => (Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation,
                      Animation<double> secondaryAnimation) =>
                  NotImplementedPage(),
              transitionDuration: Duration.zero,
            ))),
            trailing: Icon(Icons.chevron_right),
            title: Text('Invite other to join the team'),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
          child: ListTile(
            trailing: Container(
              height: 35,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                  child:
                      Text('Leave team', style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    TeamsCubit().leaveTeam(1);
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) =>
                          TeamsPage(),
                      transitionDuration: Duration.zero,
                    ));
                  }),
            ),
            title: Text('Would you like to leave the team?'),
          ),
        ),
      ],
    );
  }
}

class _BuildTeamSettings extends StatelessWidget {
  const _BuildTeamSettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 15),
          child: Text('Team Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Container(
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey.shade200))),
            child: ListTile(
              title: Row(
                children: [
                  Container(width: 100, child: Text('Name: ')),
                  SizedBox(width: 30),
                  Text('Name Name'),
                ],
              ),
            )),
        Container(
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey.shade200))),
            child: ListTile(
              title: Row(
                children: [
                  Container(width: 100, child: Text('Team Admin: ')),
                  SizedBox(width: 30),
                  Text('Name Name'),
                ],
              ),
            )),
        Container(
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey.shade200))),
            child: ListTile(
              title: Row(
                children: [
                  Container(width: 100, child: Text('Description: ')),
                  SizedBox(width: 30),
                  Container(
                    width: 220,
                    child: Text(
                        'Name Mattis molestie rhoncus fringilla nostra velit cubilia ligula proin lorem laoreet imperdiet phasellus facilisi sollicitudin cras sed urna euismod mauris'),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
