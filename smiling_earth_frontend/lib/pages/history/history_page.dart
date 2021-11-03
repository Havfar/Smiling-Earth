import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smiling_earth_frontend/models/activity.dart';
import 'package:smiling_earth_frontend/pages/history/activity_detailed.dart';
import 'package:smiling_earth_frontend/pages/history/activity_new.dart';
import 'package:smiling_earth_frontend/utils/activity_util.dart';
import 'package:smiling_earth_frontend/utils/services/activity_db_manager.dart';
import 'package:smiling_earth_frontend/utils/services/energy_db_manager.dart';
import 'package:smiling_earth_frontend/utils/smiling_earth_icon_utils.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.green),
        ),
        drawer: NavigationDrawerWidget(),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(15),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                BuildActivityListWidget(),
              ],
            ),
          ),
        ),
      );
}

class BuildActivityListWidget extends StatelessWidget {
  const BuildActivityListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ActivityGroupedByDate>>(
        future: _getActivtityGroup(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ActivityGroupedByDate>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text('Loading...'));
          }
          return snapshot.data!.isEmpty
              ? Center(child: Text('No Activities in List.'))
              : Column(
                  children: snapshot.data!
                      .map((group) => Card(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Column(children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.black12))),
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      DateFormat('EEEE, d MMM')
                                          .format(DateTime.parse(group.date)),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  Row(
                                    children: [
                                      Text("1234,12 kgCO2"),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      SmilingEarthIcon.getIcon(1234),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Row(children: [
                              Expanded(
                                child: Column(
                                  children: group.activities.map((activity) {
                                    if (activity is EnergyActivity) {
                                      return _BuildEnergyListTile(
                                          activity: activity);
                                    } else {
                                      return _BuildActivityListTile(
                                          activity: activity as Activity);
                                    }
                                  }).toList(),
                                ),
                              ),
                            ])
                          ])))
                      .toList(),
                );
        });
  }
}

class _BuildActivityListTile extends StatelessWidget {
  const _BuildActivityListTile({
    Key? key,
    required this.activity,
  }) : super(key: key);

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailedActivity(
                activity: activity,
              ),
            ),
          );
        },
        leading: Icon(getIconByActivity(activity)),
        title: Text(
            activity.runtimeType is EnergyActivity ? "Haloi" : activity.title),
        subtitle: Text(Activity.formatActivityForListTile(activity)),
        trailing: Text((13).toString() + " kgCO2"));
  }
}

class _BuildEnergyListTile extends StatelessWidget {
  const _BuildEnergyListTile({
    Key? key,
    required this.activity,
  }) : super(key: key);

  final EnergyActivity activity;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(Icons.power),
        title: Text(activity.title),
        // subtitle: Text(Activity.formatActivityForListTile(activity)),
        trailing: Text((13).toString() + " kgCO2"));
  }
}

Future<List<ActivityGroupedByDate>> _getActivtityGroup() async {
  List<ActivityInterface> activityElements = [];
  var activities = await ActivityDatabaseManager.instance.getActivities();

  var energy = await EnergyDatabaseManager.instance.getHeat();
  activityElements.addAll(activities);
  activityElements.addAll(energy);

  var groupedBy = groupBy(activityElements,
      (ActivityInterface obj) => obj.startDate!.toString().substring(0, 10));

  List<ActivityGroupedByDate> activity = [];
  for (var key in groupedBy.keys) {
    activity.add(new ActivityGroupedByDate(
        date: key, activities: groupedBy[key]!.toList()));
  }
  // ignore: deprecated_member_use
  return activity;
}

double getEmissions(Activity activity) {
  int duration = activity.getTotalDurationInMinutes();
  return duration * 0.123;
}
