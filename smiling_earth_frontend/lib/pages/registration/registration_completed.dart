import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smiling_earth_frontend/pages/home/home_page.dart';
import 'package:smiling_earth_frontend/utils/smiling_earth_icon_utils.dart';

class FinishedPage extends StatelessWidget {
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
                'Registration completed 👍',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 50, right: 50),
                child: Text(
                  'You are now ready to use the app',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
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
                        builder: (context) => HomePage(),
                      )),
                  child: Text('Lets get started >',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400)))
            ],
          )),
        ),
      );
}
