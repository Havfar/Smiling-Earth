import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/pages/registration/car_registration.dart';
import 'package:smiling_earth_frontend/pages/registration/transportation_registration.dart';
import 'package:smiling_earth_frontend/utils/services/settings_db_manager.dart';
import 'package:smiling_earth_frontend/widgets/page_indicator.dart';

class HouseRegistrationPage extends StatefulWidget {
  @override
  State<HouseRegistrationPage> createState() => _HouseRegistrationPageState();
}

class _HouseRegistrationPageState extends State<HouseRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  String _registrationNo = '';
  int _buildingYear = 2000;
  int _lastRenovation = 2000;
  int _typeOfHeating = 0;
  int _size = 100;

  @override
  Widget build(BuildContext context) => Scaffold(
        // appBar: AppBar(),
        // drawer: NavigationDrawerWidget(),
        body: Container(
          margin: EdgeInsets.only(top: 50),
          child: Center(
              child: ListView(
            children: [
              Form(
                key: _formKey,
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border(top: BorderSide(color: Colors.grey.shade200))),
                  margin: EdgeInsets.only(left: 20, right: 20),
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: [
                          Text('🏠'),
                          Text(
                              'The type of energy you use for heating and the efficiency of your heating system determine 80% of your carbon footprint from energy consumption. The building year and the year of last renovation of the house, also affect the house emissions'),
                        ],
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Building year',
                          border: OutlineInputBorder(),
                          // hintText: "Enter the car's registration number"
                        ),
                        onSaved: (value) => setState(
                            () => _buildingYear = int.tryParse(value!)!),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Year of last renovation',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        onSaved: (value) => setState(() {
                          int? valueInt = int.tryParse(value!);
                          _lastRenovation = valueInt!;
                          return;
                        }),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Size of home (square meter)',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        onSaved: (value) =>
                            setState(() => _size = int.tryParse(value!)!),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'What kind of heating do you use?',
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (value) => setState(
                            () => _typeOfHeating = int.tryParse(value!)!),
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
        ),
        bottomNavigationBar: PageIndicator(
            index: 3,
            previousPage: MaterialPageRoute(
                builder: (context) => TransportationRegistrationPage()),
            nextPage: MaterialPageRoute(
              builder: (context) => CarRegistrationPage(),
            ),
            formSumbissionFunction: () => submitHouseInformation(context)),
      );

  void submitHouseInformation(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Settings settings = Settings(
          0,
          null,
          _buildingYear.toString(),
          _lastRenovation.toString(),
          _typeOfHeating,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null);
      var settingsDbm = SettingsDatabaseManager.instance;
      settingsDbm.update(settings);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CarRegistrationPage()));
    }
  }
}

// MaterialPageRoute(builder: (context) => GoalInformationPage(),

