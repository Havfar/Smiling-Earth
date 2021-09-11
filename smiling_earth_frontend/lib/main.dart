import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/models/Activity.dart';
import 'package:smiling_earth_frontend/pages/activity_detailed.dart';
import 'package:smiling_earth_frontend/pages/activity_new.dart';
import 'package:smiling_earth_frontend/utils/activity_util.dart';
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Activities",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                    TextButton(
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => NewActivity())),
                        child: Text('Add activity'))
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text('Mulig graf')),
                  // child: new LineChartSample1()),
                  // margin: EdgeInsets.all(25)
                ),
                Expanded(
                  flex: 8,
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
                                children:
                                    snapshot.data!.reversed.map((activity) {
                                  return Card(
                                    child: ListTile(
                                      leading:
                                          Icon(getIconByActivity(activity)),
                                      title: Text(activity.title),
                                      subtitle: Text(
                                          getDuration(activity).toString()),
                                      trailing: Text(
                                          getEmissions(activity).toString() +
                                              " kgCO2"),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailedActivity(
                                              activity: activity,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }).toList(),
                              );
                      }),
                ),
              ],
            ),
          )),
    );
  }
}

int getDuration(Activity activity) {
  var from = DateTime.fromMillisecondsSinceEpoch(activity.end_timestamp);
  var to = DateTime.fromMillisecondsSinceEpoch(activity.start_timestamp);
  int duration = from.difference(to).inMinutes.round();

  return duration;
}

double getEmissions(Activity activity) {
  int duration = getDuration(activity);
  return duration * 0.123;
}
