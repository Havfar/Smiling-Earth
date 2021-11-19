import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/pages/registration/avatar_registration.dart';
import 'package:smiling_earth_frontend/pages/registration/transportation_registration.dart';
import 'package:smiling_earth_frontend/utils/services/settings_db_manager.dart';
import 'package:smiling_earth_frontend/widgets/page_indicator.dart';

class HouseRegistrationPage extends StatefulWidget {
  @override
  State<HouseRegistrationPage> createState() => _HouseRegistrationPageState();
}

class _HouseRegistrationPageState extends State<HouseRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  int _buildingYear = 2000;
  int _lastRenovation = 0;
  String _typeOfHeating = 'Electric';
  int _size = 9;
  int _heatIndex = 0;

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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'House Information 🏠',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
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
                        initialValue: _buildingYear.toString(),
                        onChanged: (value) => setState(
                            () => _buildingYear = int.tryParse(value)!),
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
                          labelText: 'Year of last renovation (optional)',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) => setState(() {
                          int? valueInt = int.tryParse(value);
                          _lastRenovation = valueInt!;
                          return;
                        }),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Size of home (square meter)',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) =>
                            setState(() => _size = int.tryParse(value)!),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('What kind of heating do you user? (default)'),
                          RadioListTile<int>(
                            title: const Text(
                              'Electric',
                              style: TextStyle(color: Colors.black54),
                            ),
                            value: 0,
                            groupValue: _heatIndex,
                            toggleable: false,
                            onChanged: (value) => (value),
                          ),
                          RadioListTile<int>(
                            title: const Text('Gas',
                                style: TextStyle(color: Colors.black54)),
                            value: 1,
                            groupValue: _heatIndex,
                            toggleable: false,
                            onChanged: (value) => (value),
                          ),
                          RadioListTile<int>(
                            title: const Text('Wood',
                                style: TextStyle(color: Colors.black54)),
                            value: 2,
                            groupValue: _heatIndex,
                            toggleable: false,
                            onChanged: (value) => (value),
                          ),
                          RadioListTile<int>(
                            title: const Text('Water',
                                style: TextStyle(color: Colors.black54)),
                            value: 3,
                            groupValue: _heatIndex,
                            toggleable: false,
                            onChanged: (value) => (value),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
        ),
        bottomNavigationBar: PageIndicator(
            index: 5,
            previousPage: MaterialPageRoute(
                builder: (context) => AvatarRegistrationPage()),
            nextPage: MaterialPageRoute(
              builder: (context) => TransportationRegistrationPage(),
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

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TransportationRegistrationPage()));
    }
  }
}

// MaterialPageRoute(builder: (context) => GoalInformationPage(),

