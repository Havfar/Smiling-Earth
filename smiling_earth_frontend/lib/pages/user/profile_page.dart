import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

class ProfilePage extends StatelessWidget {
  final int userId;

  const ProfilePage({Key? key, required this.userId}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.green),
        ),
        drawer: NavigationDrawerWidget(),
        body: Text("Profile"),
      );
}
