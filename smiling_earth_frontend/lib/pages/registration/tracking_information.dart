import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/pages/registration/benefit_information.dart';
import 'package:smiling_earth_frontend/pages/registration/goal_information.dart';
import 'package:smiling_earth_frontend/widgets/page_indicator.dart';

class TrackingInformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 50),
          child: Center(
              child: ListView(
            children: [
              Text(
                'Tracking',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Column(
                  children: [
                    Text(
                      "π΄ππΆββοΈπβοΈ",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "The app tracks your movement and automatically detects whether you walk, cycle, or drive a car. If the app detects that you are driving, the CO2 emission from the drive is calculated. \n\nAdditionally, you can manually add activities that you have done and edit the activities if they are incorrect.",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "β‘οΈπ‘π",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "The app also checks the outside temperature where you live and calculates how much energy is needed to heat your home and the CO2 emitted from producing the heat.",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ),
        bottomNavigationBar: PageIndicator(
          index: 1,
          previousPage:
              MaterialPageRoute(builder: (context) => GoalInformationPage()),
          nextPage: MaterialPageRoute(
              builder: (context) => BenefitsInformationPage()),
        ),
      );
}

// MaterialPageRoute(builder: (context) => GoalInformationPage(),

