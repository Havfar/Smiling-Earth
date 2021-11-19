import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/user/profile_cubit.dart';
import 'package:smiling_earth_frontend/pages/registration/avatar_registration.dart';
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
  String _first_name = '';
  String _last_name = '';
  String _city = '';
  String _gender = '';
  String _bio = '';
  String _weight = '80';
  String _age = '25';
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
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text('User Information 👤',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ),
              BlocProvider(
                create: (context) => ProfileCubit()..getMyProfile(),
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileRetrived) {
                      return Form(
                        key: _formKey,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  top:
                                      BorderSide(color: Colors.grey.shade200))),
                          margin: EdgeInsets.only(left: 20, right: 20),
                          padding: EdgeInsets.only(top: 20),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 30),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'First name (default)',
                                  border: OutlineInputBorder(),
                                ),
                                enabled: false,
                                initialValue: state.profile.firstName,
                                onChanged: (value) =>
                                    setState(() => _first_name = value),
                              ),
                              SizedBox(height: 30),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Last name (default)',
                                  border: OutlineInputBorder(),
                                ),
                                enabled: false,
                                initialValue: state.profile.lastName,
                                onChanged: (value) =>
                                    setState(() => _last_name = value),
                              ),
                              SizedBox(height: 30),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText:
                                      'What city do you live in? (optional)',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) => setState(() {
                                  _city = value;
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
                                onChanged: (value) =>
                                    setState(() => _age = value),
                              ),
                              SizedBox(height: 30),
                              TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: 'Weight (default)',
                                  border: OutlineInputBorder(),
                                ),
                                initialValue: '80',
                                onChanged: (value) =>
                                    setState(() => _weight = value),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (state is ProfileRetrivedError) {
                      return Text('Error ' + state.error);
                    }
                    return Center(
                        heightFactor: 100,
                        widthFactor: 100,
                        child: CircularProgressIndicator());
                  },
                ),
              )
            ],
          )),
        ),
        bottomNavigationBar: PageIndicator(
            index: 3,
            previousPage: null,
            nextPage: MaterialPageRoute(
              builder: (context) => AvatarRegistrationPage(),
            ),
            formSumbissionFunction: () => submitUserInformation(context)),
      );

  void submitUserInformation(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Settings settings = new Settings(0, null, null, null, null, null, null,
          null, null, null, null, _age, _weight, null);
      var settingsDbm = SettingsDatabaseManager.instance;
      settingsDbm.update(settings);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );

      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => AvatarRegistrationPage()));
    }
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => AvatarRegistrationPage()));
  }
}
