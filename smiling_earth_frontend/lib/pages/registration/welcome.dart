import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smiling_earth_frontend/pages/registration/goal_information.dart';
import 'package:smiling_earth_frontend/utils/smiling_earth_icon_utils.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        // appBar: AppBar(),
        // drawer: NavigationDrawerWidget(),
        body: Container(
          margin: EdgeInsets.only(top: 100),
          child: Center(
              child: Column(
            children: [
              Text(
                '👋',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 55, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 50, right: 50),
                child: Text(
                  'Welcome to Smiling Earth!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              SmilingEarthIcon.getLargeIcon(),
              SizedBox(
                height: 50,
              ),
              TextButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GoalInformationPage(),
                      )),
                  child: Text('Start registration >',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400)))
            ],
          )),
        ),
      );
}
