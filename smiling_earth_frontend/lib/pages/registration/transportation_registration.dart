import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/pages/registration/car_registration.dart';
import 'package:smiling_earth_frontend/pages/registration/house_registration.dart';
import 'package:smiling_earth_frontend/utils/activity_util.dart';
import 'package:smiling_earth_frontend/utils/services/settings_db_manager.dart';
import 'package:smiling_earth_frontend/widgets/page_indicator.dart';

class TransportationRegistrationPage extends StatefulWidget {
  @override
  State<TransportationRegistrationPage> createState() =>
      _TransportationRegistrationPageState();
}

class _TransportationRegistrationPageState
    extends State<TransportationRegistrationPage> {
  final List<AppActivityType> selected = [];
  @override
  Widget build(BuildContext context) => Scaffold(
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'What means of transportation do you use on a regular basis?',
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
                    .map((activity) => Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey.shade300))),
                        child: CheckboxListTile(
                            title: Text(
                                getTransporationNameByActivityType(activity)),
                            value: isSelected(activity),
                            onChanged: (bool? value) {
                              updateSelected(activity);
                            },
                            secondary: Icon(
                                getTransporationIconByActivityType(activity)))))
                    .toList()),
          ],
        ),
      ),
      bottomNavigationBar: PageIndicator(
        index: 6,
        previousPage: MaterialPageRoute(
          builder: (context) => HouseRegistrationPage(),
        ),
        nextPage:
            MaterialPageRoute(builder: (context) => CarRegistrationPage()),
        formSumbissionFunction: () => submitForm(),
      ));

  void submitForm() {
    String selectedIndexes = '';
    for (var type in selected) {
      selectedIndexes += type.index.toString() + ',';
    }

    var newSettings = Settings(0, selectedIndexes, null, null, null, null, null,
        null, null, null, null, null, null, null);
    SettingsDatabaseManager.instance.update(newSettings);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CarRegistrationPage()));
  }

  void updateSelected(AppActivityType type) {
    if (isSelected(type)) {
      setState(() {
        selected.remove(type);
      });
    } else {
      setState(() {
        selected.add(type);
      });
    }
  }

  bool isSelected(AppActivityType type) {
    return selected.contains(type);
  }
}
