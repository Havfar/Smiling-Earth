import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/pages/registration/house_registration.dart';
import 'package:smiling_earth_frontend/utils/services/settings_db_manager.dart';
import 'package:smiling_earth_frontend/widgets/page_indicator.dart';

class UserInformationRegistration extends StatefulWidget {
  UserInformationRegistration({Key? key}) : super(key: key);

  @override
  _UserInformationRegistrationState createState() =>
      _UserInformationRegistrationState();
}

class _UserInformationRegistrationState
    extends State<UserInformationRegistration> {
  final _formKey = GlobalKey<FormState>();
  String _first_name = 'Are';
  String _last_name = 'Odin';
  String _city = '';
  String _gender = '';
  String _bio = '';
  double _weight = 80;
  int _age = 25;
  int _profilePicture = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        // appBar: AppBar(),
        // drawer: NavigationDrawerWidget(),
        body: Container(
          margin: EdgeInsets.only(top: 50),
          child: Center(
              child: ListView(
            children: [
              Text('User Information'),
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
                      SizedBox(height: 30),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'First name',
                          border: OutlineInputBorder(),
                          // hintText: "Enter the car's registration number"
                        ),
                        enabled: false,
                        initialValue: _first_name,
                        onSaved: (value) =>
                            setState(() => _first_name = value!),
                        // The validator receives the text that the user has entered.
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Last name',
                          border: OutlineInputBorder(),
                          // hintText: "Enter the car's registration number"
                        ),
                        enabled: false,
                        initialValue: _last_name,
                        onSaved: (value) => setState(() => _last_name = value!),
                        // The validator receives the text that the user has entered.
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'What City do you live in? (optional)',
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (value) => setState(() {
                          _city = value!;
                        }),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'What City do you live in? (optional)',
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (value) => setState(() {
                          _city = value!;
                        }),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'How old are you? (optional)',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        onSaved: (value) =>
                            setState(() => _age = int.tryParse(value!)!),
                        // The validator receives the text that the user has entered.
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: 'Weight (default)',
                          border: OutlineInputBorder(),
                        ),
                        initialValue: '80',
                        onSaved: (value) =>
                            setState(() => _weight = double.tryParse(value!)!),
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
                      TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: 'Choose a profile picture',
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (value) => setState(
                            () => _profilePicture = int.tryParse(value!)!),
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
            index: 1,
            previousPage: null,
            nextPage: MaterialPageRoute(
              builder: (context) => HouseRegistrationPage(),
            ),
            formSumbissionFunction: () => submitUserInformation(context)),
      );

  void submitUserInformation(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Settings settings = new Settings(0, null, null, null, null, null, null,
          null, null, _first_name, _last_name, _age, _weight, _profilePicture);
      var settingsDbm = SettingsDatabaseManager.instance;
      settingsDbm.update(settings);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );

      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => HouseRegistrationPage()));
    }
  }
}
