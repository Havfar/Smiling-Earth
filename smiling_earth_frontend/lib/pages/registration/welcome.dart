import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/user/profile_cubit.dart';
import 'package:smiling_earth_frontend/pages/registration/goal_information.dart';
import 'package:smiling_earth_frontend/utils/services/settings_db_manager.dart';
import 'package:smiling_earth_frontend/utils/smiling_earth_icon_utils.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        // appBar: AppBar(),
        // drawer: NavigationDrawerWidget(),
        body: Container(
          margin: EdgeInsets.only(top: 100),
          child: BlocProvider(
            create: (context) => ProfileCubit()..getMyProfile(),
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileRetrived) {
                  return Center(
                      child: Column(
                    children: [
                      Text(
                        '👋',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 55, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 50, right: 50),
                        child: Text(
                          'Welcome to Smiling Earth!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.w500),
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
                          onPressed: () {
                            var settingsDbm = SettingsDatabaseManager.instance;
                            settingsDbm.add(Settings(
                                0,
                                null,
                                null,
                                null,
                                null,
                                null,
                                null,
                                null,
                                null,
                                state.profile.firstName,
                                state.profile.lastName,
                                null,
                                null,
                                null));
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GoalInformationPage(),
                            ));
                          },
                          child: Text('Start registration >',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400)))
                    ],
                  ));
                }
                return Center(
                    heightFactor: 100,
                    widthFactor: 100,
                    child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      );
}
