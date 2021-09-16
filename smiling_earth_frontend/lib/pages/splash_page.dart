import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/pages/home_page.dart';
import 'package:smiling_earth_frontend/pages/log_in_page.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          margin: EdgeInsets.all(100),
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20, top: 50),
                  child: Image(
                      height: 160,
                      width: 160,
                      image: AssetImage('assets/img/smiling-earth/earth1.png')),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 60),
                  child: Text(
                    "Smiling Earth",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LogInPage()),
                          ),
                      child: Text("Log in")),
                ),
                Text("Or"),
                ElevatedButton(
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        ),
                    child: Text("Sign up"))
              ],
            ),
          ),
        ),
      );
}
