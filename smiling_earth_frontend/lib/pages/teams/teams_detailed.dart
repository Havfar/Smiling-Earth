import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_page.dart';

class TeamsDetailedPage extends StatelessWidget {
  final int? id;
  TeamsDetailedPage({required this.id});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TeamsPage(),
          )),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: ListView(
          children: [Text("Detailed" + id.toString())],
        ),
      ));
}
