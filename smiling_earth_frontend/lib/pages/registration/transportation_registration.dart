import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/pages/registration/car_registration.dart';
import 'package:smiling_earth_frontend/pages/registration/house_registration.dart';
import 'package:smiling_earth_frontend/utils/activity_util.dart';
import 'package:smiling_earth_frontend/widgets/page_indicator.dart';

class TransportationRegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      // appBar: AppBar(),
      // drawer: NavigationDrawerWidget(),
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transportation',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'What means of transportation do you use on a regular basis?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Column(
                children: getTransportationTypes()
                    .map((activity) => CheckboxWidget(
                          activity: activity,
                        ))
                    .toList()),
          ],
        ),
      ),
      bottomNavigationBar: PageIndicator(
        index: 2,
        previousPage: MaterialPageRoute(
          builder: (context) => HouseRegistrationPage(),
        ),
        nextPage:
            MaterialPageRoute(builder: (context) => CarRegistrationPage()),
      ));
}

// MaterialPageRoute(builder: (context) => GoalInformationPage(),

/// This is the stateful widget that the main application instantiates.
class CheckboxWidget extends StatefulWidget {
  final AppActivityType activity;
  const CheckboxWidget({Key? key, required this.activity}) : super(key: key);

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _CheckboxWidgetState extends State<CheckboxWidget> {
  bool _checked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
      child: CheckboxListTile(
        title: Text(getTransporationNameByActivityType(widget.activity)),
        value: _checked,
        onChanged: (bool? value) {
          setState(() {
            _checked = value!;
          });
        },
        secondary: Icon(getTransporationIconByActivityType(widget.activity)),
      ),
    );
  }
}
