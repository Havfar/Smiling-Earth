import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/models/Activity.dart';
import 'package:smiling_earth_frontend/utils/services/activity_recognition.dart';
import 'package:smiling_earth_frontend/utils/services/database.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(new SmilingEarthHome());
}

class SmilingEarthHome extends StatefulWidget {
  @override
  _SmilingEarthHomeState createState() => new _SmilingEarthHomeState();
}

class _SmilingEarthHomeState extends State<SmilingEarthHome> {
  @override
  void initState() {
    super.initState();
    startActivityMonitor();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: AppBar(
            title: Text('Home'),
            centerTitle: true,
            backgroundColor: Colors.blue,
          ),
          drawer: NavigationDrawerWidget(),
          body: new Center(
            child: FutureBuilder<List<Activity>>(
                future: DatabaseHelper.instance.getActivities(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Activity>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Text('Loading...'));
                  }
                  return snapshot.data!.isEmpty
                      ? Center(child: Text('No Activities in List.'))
                      : ListView(
                          children: snapshot.data!.map((activity) {
                            return Card(
                              child: ListTile(
                                leading: Icon(activity.getIcon()),
                                title: Text(activity.title),
                                subtitle: Text(
                                    DateTime.fromMillisecondsSinceEpoch(
                                            activity.timestamp)
                                        .toString()),
                              ),
                            );
                          }).toList(),
                        );
                }),
          )),
    );
  }
}
