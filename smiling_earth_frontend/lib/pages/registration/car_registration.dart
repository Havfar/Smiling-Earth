import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/pages/registration/climate_action.dart';
import 'package:smiling_earth_frontend/pages/registration/transportation_registration.dart';
import 'package:smiling_earth_frontend/utils/services/settings_db_manager.dart';
import 'package:smiling_earth_frontend/widgets/page_indicator.dart';

class CarRegistrationPage extends StatefulWidget {
  @override
  State<CarRegistrationPage> createState() => _CarRegistrationPageState();
}

class _CarRegistrationPageState extends State<CarRegistrationPage> {
  bool _ownsCar = false;
  final _formKey = GlobalKey<FormState>();
  String _registrationNo = '';
  int _estimatedValueOfCar = 0;
  int _estimatedDrivingDistance = 0;
  int _estimatedOwnership = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        // appBar: AppBar(),
        // drawer: NavigationDrawerWidget(),
        body: Container(
          margin: EdgeInsets.only(top: 50),
          child: Center(
              child: ListView(
            children: [
              SwitchListTile(
                title: Text('Do you own a car? 🚙'),
                value: _ownsCar,
                onChanged: (bool value) {
                  setState(() {
                    _ownsCar = value;
                  });
                },
              ),
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
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Registration Number',
                          border: OutlineInputBorder(),
                          // hintText: "Enter the car's registration number"
                        ),
                        enabled: _ownsCar,
                        onSaved: (value) =>
                            setState(() => _registrationNo = value!),
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
                          labelText: 'Estimated value of the car',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        enabled: _ownsCar,
                        onSaved: (value) => setState(() {
                          int? valueInt = int.tryParse(value!);
                          _estimatedValueOfCar = valueInt!;
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
                          labelText: 'Estimated yearly driving distance',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        enabled: _ownsCar,
                        onSaved: (value) => setState(() =>
                            _estimatedDrivingDistance = int.tryParse(value!)!),
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
                          labelText: 'Planned duration of ownership (years)',
                          border: OutlineInputBorder(),
                        ),
                        enabled: _ownsCar,
                        onSaved: (value) => setState(
                            () => _estimatedOwnership = int.tryParse(value!)!),
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
              builder: (context) => ClimateActionPage(),
            ),
            formSumbissionFunction: () => submitCarInformation(context)),
      );

  void submitCarInformation(BuildContext context) {
    if (_ownsCar) {
      if (_formKey.currentState!.validate()) {
        Settings settings = Settings(
            0,
            null,
            null,
            null,
            null,
            this._registrationNo,
            this._estimatedValueOfCar,
            this._estimatedDrivingDistance,
            this._estimatedOwnership,
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
            .push(MaterialPageRoute(builder: (context) => ClimateActionPage()));
      }
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ClimateActionPage()));
    }
  }
}

// Define a custom Form widget.
class CarForm extends StatefulWidget {
  const CarForm({Key? key}) : super(key: key);

  @override
  CarFormState createState() {
    return CarFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class CarFormState extends State<CarForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Minutes',
                border: OutlineInputBorder(),
              ),
              enabled: false,
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
