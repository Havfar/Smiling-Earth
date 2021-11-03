import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/pages/fluttermoji.dart';
import 'package:smiling_earth_frontend/utils/services/settings_db_manager.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green),
      ),
      drawer: NavigationDrawerWidget(),
      body: ListView(children: [
        Text('Settings'),
        FutureBuilder<Settings>(
            future: SettingsDatabaseManager.instance.get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('User information'),
                    ListTile(
                      title: Text('id'),
                      trailing: Text(snapshot.data!.id.toString()),
                    ),
                    ListTile(
                      title: Text('Age'),
                      trailing: Text(snapshot.data!.age.toString()),
                    ),
                    ListTile(
                      title: Text('First Name'),
                      trailing: Text(snapshot.data!.first_name.toString()),
                    ),
                    ListTile(
                      title: Text('Last name'),
                      trailing: Text(snapshot.data!.last_name.toString()),
                    ),
                    SizedBox(height: 30),
                    Text('House information'),
                    ListTile(
                      title: Text('Year of building'),
                      trailing: Text(snapshot.data!.building_year.toString()),
                    ),
                    ListTile(
                      title: Text('Last rennovated'),
                      trailing:
                          Text(snapshot.data!.last_renocation_year.toString()),
                    ),
                    ListTile(
                      title: Text('Heating Type'),
                      trailing: Text(snapshot.data!.heating_type.toString()),
                    ),
                    Text('Car information'),
                    ListTile(
                      title: Text('Car registration No'),
                      trailing: Text(snapshot.data!.car_reg_no.toString()),
                    ),
                    ListTile(
                      title: Text('Car value'),
                      trailing: Text(snapshot.data!.car_value.toString()),
                    ),
                    ListTile(
                      title: Text('Planned duration of ownership'),
                      trailing:
                          Text(snapshot.data!.car_planned_ownership.toString()),
                    ),
                    SizedBox(height: 30),
                    ListTile(
                      title: Text('Edit Avatar'),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FlutterMojiPage(
                          title: 'test',
                        ),
                      )),
                    ),
                    ListTile(
                      title: Text('Edit Pledges'),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FlutterMojiPage(
                          title: 'test',
                        ),
                      )),
                    ),
                  ],
                );
              } else {
                return Text('Loading');
              }
            })
      ]));
}
