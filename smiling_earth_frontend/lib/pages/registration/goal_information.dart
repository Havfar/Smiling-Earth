import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/pages/registration/tracking_information.dart';
import 'package:smiling_earth_frontend/pages/registration/welcome.dart';
import 'package:smiling_earth_frontend/utils/smiling_earth_icon_utils.dart';
import 'package:smiling_earth_frontend/widgets/page_indicator.dart';

class GoalInformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        // appBar: AppBar(),
        // drawer: NavigationDrawerWidget(),
        body: Container(
          margin: EdgeInsets.only(top: 150),
          child: Center(
              child: Column(
            children: [
              Text(
                'About the app',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmilingEarthIcon.getSmallIcon(1),
                  SmilingEarthIcon.getSmallIcon(2),
                  SmilingEarthIcon.getSmallIcon(3),
                  SmilingEarthIcon.getSmallIcon(4),
                  SmilingEarthIcon.getSmallIcon(5),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Text(
                  "This app aims to make you more aware of how your daily habits and energy use affect the environment. \n\nThe Earth is happy when you have a carbon footprint below 4kgCO2 per day. However, if you exceed the limit of 4 kgCO2, the Earth's mood and health change accordingly.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          )),
        ),
        bottomNavigationBar: PageIndicator(
          index: 0,
          previousPage: MaterialPageRoute(builder: (context) => WelcomePage()),
          nextPage: MaterialPageRoute(
              builder: (context) => TrackingInformationPage()),
        ),
      );
}

// MaterialPageRoute(builder: (context) => GoalInformationPage(),

