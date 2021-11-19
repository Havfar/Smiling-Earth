import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:smiling_earth_frontend/bloc/login/bloc/bloc_login_bloc.dart';
import 'package:smiling_earth_frontend/pages/challenges/challenges_page.dart';
import 'package:smiling_earth_frontend/pages/duel/duel_list.dart';
import 'package:smiling_earth_frontend/pages/find_people_page.dart';
import 'package:smiling_earth_frontend/pages/history/history_page.dart';
import 'package:smiling_earth_frontend/pages/home/home_page.dart';
import 'package:smiling_earth_frontend/pages/leaderboards_page.dart';
import 'package:smiling_earth_frontend/pages/settings_page.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_page.dart';
import 'package:smiling_earth_frontend/pages/user/follower_page.dart';
import 'package:smiling_earth_frontend/pages/user/my_profile.dart';
import 'package:smiling_earth_frontend/utils/services/settings_db_manager.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Color.fromRGBO(50, 75, 205, 1),
        child: ListView(
          children: <Widget>[
            buildHeader(
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MyProfilePage(),
              )),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  buildMenuItem(
                    text: 'Home',
                    icon: Icons.home,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Activities',
                    icon: Icons.update,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  // const SizedBox(height: 12),
                  // buildMenuItem(
                  //   text: 'Notifications',
                  //   icon: Icons.notifications,
                  //   onClicked: () => selectedItem(context, 3),
                  // ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Settings',
                    icon: Icons.settings,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  const SizedBox(height: 10),
                  Divider(color: Colors.white70),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Find users',
                    icon: Icons.people,
                    onClicked: () => selectedItem(context, 5),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Challenges',
                    icon: Icons.emoji_events,
                    onClicked: () => selectedItem(context, 6),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Teams',
                    icon: Icons.groups,
                    onClicked: () => selectedItem(context, 7),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Duels',
                    icon: Icons.compare_arrows,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 20),
                  SignOut(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              Container(
                  width: 50, height: 50, child: FluttermojiCircleAvatar()),
              SizedBox(width: 20),
              FutureBuilder<String>(
                  future: SettingsDatabaseManager.instance.getName(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: 130,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            Text(
                              'Go to my profile',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    }
                    return Text(
                      'Loading.. ',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    );
                  }),
            ],
          ),
        ),
      );

  Widget buildSearchField() {
    final color = Colors.white;

    return TextField(
      style: TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HistoryPage(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DuelsPage(),
        ));
        break;
      case 3:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => FlutterMojiPage(
        //     title: 'test',
        //   ),
        // ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SettingsPage(),
        ));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FollowerPage(),
        ));
        break;
      case 6:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChallengesPage(),
        ));
        break;
      case 7:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TeamsPage(),
        ));
        break;
      case 8:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LeaderboardPage(),
        ));
        break;
      case 9:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FollowersPage(),
        ));
        break;
    }
  }
}

class SignOut extends StatelessWidget {
  const SignOut({Key? key}) : super(key: key);

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  @override
  Widget build(BuildContext context) {
    _onLogoutButtonPressed() {
      BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
    }

    final color = Colors.white;
    return Container(
        child: ListTile(
      leading: Icon(Icons.logout, color: color),
      title: Text('Sign out', style: TextStyle(color: color)),
      onTap: () => _onLogoutButtonPressed(),
    ));
  }
}
