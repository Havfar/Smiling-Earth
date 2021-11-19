import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/pages/registration/benefit_information.dart';
import 'package:smiling_earth_frontend/pages/registration/goal_information.dart';
import 'package:smiling_earth_frontend/widgets/page_indicator.dart';

class TrackingInformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 150),
          child: Center(
              child: Column(
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
                      "🚴🚙🚶‍♂️🚌✈️",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "The app tracks your movement and automatically detect wheter you walk, cycle or drive a car. If the app detects that you are driving, the CO2 emission from the drive is calcualted.\n\nAdditionally you can manually add activites that you have done, and edit the activites if they are incorrect.",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "⚡️💡🔌",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "The app also checks the outside temperature where you live, and calculates how much energy is needed to heat your home, and the CO2 emitted from producing the heat.",
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

