import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/pages/registration/pledge_registration.dart';

class ClimateActionPage extends StatelessWidget {
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
              'Climate Action',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Image(
                  height: 250,
                  width: 250,
                  image: AssetImage('assets/img/sdg13.gif')),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.only(left: 50, right: 50),
              child: Text(
                'As part of the United Nations Sustainable Development Goal No. 13, we need to take urgent action to combat climate change and its impact',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            TextButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PledgeRegistrationPage(),
                    )),
                child: Text('I want to help!',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w400)))
          ],
        )),
      ));
}
