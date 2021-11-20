import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/pages/registration/tracking_information.dart';
import 'package:smiling_earth_frontend/pages/registration/user_information.dart';
import 'package:smiling_earth_frontend/widgets/page_indicator.dart';

class BenefitsInformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 150),
          child: Center(
              child: Column(
            children: [
              Text(
                'Benefits',
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
                      "💰🏃‍♀️🍃",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "There are many benefits of choosing the greener option.\n In addition to helping to save the planet and reach the 2-degree goal of the United Nations, you can save money and gain health benefits if you choose to walk or cycle instead of driving.",
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
          index: 2,
          previousPage: MaterialPageRoute(
              builder: (context) => TrackingInformationPage()),
          nextPage: MaterialPageRoute(
              builder: (context) => UserInformationRegistration()),
        ),
      );
}

// MaterialPageRoute(builder: (context) => GoalInformationPage(),

