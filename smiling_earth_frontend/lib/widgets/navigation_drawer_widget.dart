import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/bloc/login/bloc/bloc_login_bloc.dart';
import 'package:smiling_earth_frontend/pages/challenges/challenges_page.dart';
import 'package:smiling_earth_frontend/pages/favourites_page.dart';
import 'package:smiling_earth_frontend/pages/find_people_page.dart';
import 'package:smiling_earth_frontend/pages/history/history_page.dart';
import 'package:smiling_earth_frontend/pages/home_page.dart';
import 'package:smiling_earth_frontend/pages/leaderboards_page.dart';
import 'package:smiling_earth_frontend/pages/notification_page.dart';
import 'package:smiling_earth_frontend/pages/profile_page.dart';
import 'package:smiling_earth_frontend/pages/settings_page.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_page.dart';
import 'package:smiling_earth_frontend/pages/user/follower_page.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    final name = 'Sarah Abs';
    final email = 'sarah@abs.com';
    final urlImage =
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

    return Drawer(
      child: Material(
        color: Color.fromRGBO(50, 75, 205, 1),
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProfilePage(),
              )),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  buildMenuItem(
                    text: 'Home',
                    icon: Icons.home,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 12),
                  buildMenuItem(
                    text: 'History',
                    icon: Icons.update,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 12),
                  buildMenuItem(
                    text: 'Profile',
                    icon: Icons.account_circle,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  // const SizedBox(height: 12),
                  // buildMenuItem(
                  //   text: 'Notifications',
                  //   icon: Icons.notifications,
                  //   onClicked: () => selectedItem(context, 3),
                  // ),
                  const SizedBox(height: 12),
                  buildMenuItem(
                    text: 'Settings',
                    icon: Icons.settings,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  const SizedBox(height: 12),
                  Divider(color: Colors.white70),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Find users',
                    icon: Icons.people,
                    onClicked: () => selectedItem(context, 5),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Challenges',
                    icon: Icons.emoji_events,
                    onClicked: () => selectedItem(context, 6),
                  ),
                  const SizedBox(height: 12),
                  buildMenuItem(
                    text: 'Teams',
                    icon: Icons.groups,
                    onClicked: () => selectedItem(context, 7),
                  ),
                  const SizedBox(height: 12),
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
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
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
          builder: (context) => FavouritesPage(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NotificationsPage(),
        ));
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
