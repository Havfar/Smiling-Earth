import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smiling_earth_frontend/pages/registration/climate_action.dart';
import 'package:smiling_earth_frontend/pages/registration/house_registration.dart';
import 'package:smiling_earth_frontend/widgets/circle_icon.dart';
import 'package:smiling_earth_frontend/widgets/page_indicator.dart';

class PledgeRegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        // appBar: AppBar(),
        // drawer: NavigationDrawerWidget(),
        body: Container(
          margin: EdgeInsets.only(top: 20),
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                '  Make a pledge',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  child: GridView.count(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  PledgeWidget(),
                  PledgeWidget(),
                  PledgeWidget(),
                  PledgeWidget(),
                  PledgeWidget(),
                  PledgeWidget(),
                  PledgeWidget(),
                  PledgeWidget(),
                ],
              ))
            ],
          ),
        ),
        bottomNavigationBar: PageIndicator(
          index: 5,
          previousPage:
              MaterialPageRoute(builder: (context) => ClimateActionPage()),
          nextPage:
              MaterialPageRoute(builder: (context) => HouseRegistrationPage()),
        ),
      );
}

class PledgeWidget extends StatefulWidget {
  PledgeWidget({Key? key}) : super(key: key);

  @override
  _PledgeWidgetState createState() => _PledgeWidgetState();
}

class _PledgeWidgetState extends State<PledgeWidget> {
  bool selected = false;

  _PledgeWidgetState();

  @override
  Widget build(BuildContext context) {
    if (selected) {
      return Card(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.green, width: 2),
              borderRadius: BorderRadius.circular(4.0)),
          child: InkWell(
            onTap: () => setState(() {
              selected = !selected;
            }),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleIcon(
                              backgroundColor: Colors.lightBlue.shade100,
                              emoji: '🚲'),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 60,
                            child: Text('Ride my bike',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'I pledge to ride my bike instead of driving when i can')
                    ],
                  ),
                  Icon(Icons.check_circle, color: Colors.green)
                ],
              ),
            ),
          ));
    }
    return Card(
        child: InkWell(
      onTap: () => setState(() {
        selected = !selected;
      }),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleIcon(
                        backgroundColor: Colors.lightBlue.shade100,
                        emoji: '🚲'),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 60,
                      child: Text('Ride my bike',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text('I pledge to ride my bike instead of driving when i can')
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
