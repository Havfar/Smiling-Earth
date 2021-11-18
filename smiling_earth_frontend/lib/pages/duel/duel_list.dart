import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

class DuelsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green),
        backgroundColor: Colors.white,
      ),
      drawer: NavigationDrawerWidget(),
      body: Container(
        margin: EdgeInsets.all(15),
        child: ListView(
          children: [
            Center(
                child: Text(
              'This is a preview of a future part of the application.\n The purpose is for you to challenge a friend to reduce emissions by compare your habits. The user with the most sustainable habits per week wins',
              textAlign: TextAlign.center,
            )),
            SizedBox(height: 25),
            Text('My Duels',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            Card(
                child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  SizedBox(height: 15),
                  SizedBox(height: 15),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [Text('  You    ')]),
                        Text('vs'),
                        Column(children: [Text('John  Doe')])
                      ]),
                  SizedBox(height: 15),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      child: LinearProgressIndicator(
                          value: 0.4,
                          minHeight: 30,
                          backgroundColor: Colors.green,
                          color: Colors.blue),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: [Text('18 kg CO2')]),
                        Column(children: [Text('26 kg CO2')])
                      ]),
                  SizedBox(height: 15),
                ],
              ),
            )),
          ],
        ),
      ));
}
