import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smiling_earth_frontend/models/activity.dart';
import 'package:smiling_earth_frontend/pages/history/activity_detailed.dart';
import 'package:smiling_earth_frontend/pages/history/activity_new.dart';
import 'package:smiling_earth_frontend/utils/services/activity_db_manager.dart';
import 'package:smiling_earth_frontend/utils/services/energy_db_manager.dart';
import 'package:smiling_earth_frontend/utils/smiling_earth_icon_utils.dart';
import 'package:smiling_earth_frontend/utils/string_utils.dart';
import 'package:smiling_earth_frontend/widgets/help_widget.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.green),
            actions: [
              HelpWidget(
                  title: 'Recorded Activity',
                  content:
                      'You can view, edit, add, and publish your recorded activity on this page. By long-pressing on an item in the list, you can select items to be merged or deleted. If you tap on one of the items, you preview a detailed view of the activity with the option of editing or publishing the activity to your network.')
            ]),
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

class BuildActivityListWidget extends StatefulWidget {
  const BuildActivityListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<BuildActivityListWidget> createState() =>
      _BuildActivityListWidgetState();
}

class _BuildActivityListWidgetState extends State<BuildActivityListWidget> {
  bool selectable = false;
  List<Activity> selectedActivities = [];

  void _toggleSelectable() {
    setState(() {
      selectedActivities = [];
      selectable = !selectable;
    });
  }

  bool _isSelected(Activity activity) {
    return selectedActivities.map((item) => item.id).contains(activity.id);
  }

  void addOrRemovetoSelected(Activity activity) {
    if (_isSelected(activity)) {
      setState(() {
        selectedActivities.removeWhere((item) => item.id == activity.id);
      });
    } else {
      setState(() {
        selectedActivities.add(activity);
      });
    }
  }

  Future<void> _mergeActivites() async {
    String title = selectedActivities.first.title;
    var startDate = selectedActivities.first.startDate;
    var endDate = selectedActivities.first.endDate;
    var type = selectedActivities.first.type;
    for (var activity in selectedActivities) {
      if (activity.startDate!.compareTo(startDate!) < 0) {
        startDate = activity.startDate;
      }
      if (activity.endDate!.compareTo(endDate!) > 0) {
        endDate = activity.endDate;
      }
    }
    Activity merged = Activity(
        title: title, startDate: startDate, endDate: endDate, type: type);
    // print('title: $title, start: $startDate, end: $endDate, type: $type');

    await ActivityDatabaseManager.instance.batchRemove(selectedActivities);
    await ActivityDatabaseManager.instance.add(merged);
    _toggleSelectable();
  }

  Future<void> _deleteActivities() async {
    // print('delete');
    await ActivityDatabaseManager.instance.batchRemove(selectedActivities);
    _toggleSelectable();
  }

  Row getEditingTool() {
    if (selectable) {
      return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        TextButton(onPressed: () => _toggleSelectable(), child: Text("Cancle")),
        SizedBox(width: 10),
        TextButton(
            onPressed:
                selectedActivities.length > 1 ? () => _mergeActivites() : null,
            child: Text("Merge")),
        SizedBox(width: 10),
        TextButton(
            onPressed: selectedActivities.isNotEmpty
                ? () => _deleteActivities()
                : null,
            child: Text("Delete"))
      ]);
    }
    return Row(
      children: [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getEditingTool(),
        FutureBuilder<List<ActivityGroupedByDate>>(
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
                          .map((group) => Column(
                                children: [
                                  Card(
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Column(children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.black12))),
                                          padding: EdgeInsets.all(5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  DateFormat('EEEE, d MMM')
                                                      .format(group.date),
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                              Row(
                                                children: [
                                                  Text(
                                                      "${group.emissions.roundToDouble()} kgCO2"),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  SmilingEarthIcon.getIcon(
                                                      group.emissions),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Row(children: [
                                          Expanded(
                                            child: Column(
                                              children: group.activities
                                                  .map((activity) {
                                                if (activity
                                                    is EnergyActivity) {
                                                  return _BuildEnergyListTile(
                                                      activity: activity);
                                                } else {
                                                  Activity act =
                                                      activity as Activity;
                                                  return _BuildActivityListTile(
                                                    selected: _isSelected(act),
                                                    activity: act,
                                                    onLongPress: () =>
                                                        _toggleSelectable(),
                                                    selectable: selectable,
                                                    onSelected: () =>
                                                        addOrRemovetoSelected(
                                                            act),
                                                  );
                                                }
                                              }).toList(),
                                            ),
                                          ),
                                        ])
                                      ])),
                                ],
                              ))
                          .toList(),
                    );
            }),
      ],
    );
  }
}

class _BuildActivityListTile extends StatelessWidget {
  const _BuildActivityListTile({
    Key? key,
    required this.activity,
    required this.selectable,
    required this.onLongPress,
    required this.onSelected,
    required this.selected,
  }) : super(key: key);

  final Activity activity;
  final bool selectable;
  final bool selected;
  final void Function() onLongPress;
  final void Function() onSelected;

  @override
  Widget build(BuildContext context) {
    if (selectable) {
      return ListTile(
          selected: selected,
          onLongPress: onLongPress,
          onTap: onSelected,
          leading: Icon(selected
              ? Icons.radio_button_checked
              : Icons.radio_button_unchecked),
          title: Text(activity.title),
          subtitle: Text(Activity.formatActivityForListTile(activity)),
          trailing: Text(
              "${activity.getEmission().roundToDouble().toString()} kgCO2"));
    }
    return ListTile(
        onLongPress: onLongPress,
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
        leading: Icon(activity.getIcon()),
        title: Text(activity.title),
        subtitle: Text(Activity.formatActivityForListTile(activity)),
        trailing:
            Text("${activity.getEmission().roundToDouble().toString()} kgCO2"));
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
        leading: Icon(Icons.bolt),
        title: Text(activity.title),
        trailing: Text("${roundOffToXDecimal(activity.getEmission())} kgCO2"));
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
        date: DateTime.parse(key),
        activities: groupedBy[key]!.toList(),
        emissions: sumActivityGroupEmission(groupedBy[key]!.toList())));
  }

  activity.sort((a, b) {
    return -a.date.compareTo(b.date);
  });

  return activity;
}

double sumActivityGroupEmission(List<ActivityInterface> activities) {
  double emissions = 0;
  for (var activity in activities) {
    emissions += activity.getEmission();
  }
  return emissions;
}
