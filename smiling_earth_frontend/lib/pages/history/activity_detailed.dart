import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/models/activity.dart';
import 'package:smiling_earth_frontend/pages/history/actiivity_publish.dart';
import 'package:smiling_earth_frontend/pages/history/activity_edit.dart';
import 'package:smiling_earth_frontend/pages/history/history_page.dart';
import 'package:smiling_earth_frontend/utils/activity_util.dart';
import 'package:smiling_earth_frontend/utils/services/activity_db_manager.dart';

class DetailedActivity extends StatefulWidget {
  final Activity activity;

  const DetailedActivity({required this.activity});

  @override
  _DetailedActivityState createState() => _DetailedActivityState();
}

class _DetailedActivityState extends State<DetailedActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarActivityWidget(widget: widget),
      body: Container(
        padding: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            HeaderWidget(widget: widget),
            KeyInformation(widget: widget),
            StartTimeWidget(widget: widget),
            EndTimeWidget(widget: widget),
            TagWidget(),
          ],
        ),
      ),
    );
  }
}

class TagWidget extends StatelessWidget {
  const TagWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12))),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Tag'),
          ChoiceChip(
            selected: true,
            label: Text("Commute"),
            disabledColor: Colors.greenAccent,
          ),
        ],
      ),
    );
  }
}

class EndTimeWidget extends StatelessWidget {
  const EndTimeWidget({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final DetailedActivity widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12))),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('End time: '),
          Text(Activity.formatDatetime(widget.activity.endDate))
        ],
      ),
    );
  }
}

class StartTimeWidget extends StatelessWidget {
  const StartTimeWidget({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final DetailedActivity widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12))),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Start time: '),
          Text(Activity.formatDatetime(widget.activity.startDate))
        ],
      ),
    );
  }
}

class KeyInformation extends StatelessWidget {
  const KeyInformation({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final DetailedActivity widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: Colors.black12),
              bottom: BorderSide(color: Colors.black12))),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Row(children: [
                Icon(
                  Icons.filter_drama,
                  size: 40,
                ),
                Text(
                  getEmissions(widget.activity).toString() + ' kg Co2',
                  style: TextStyle(fontSize: 18),
                )
              ])
            ],
          ),
          Column(
            children: [
              Row(children: [
                Icon(Icons.local_fire_department, size: 40, color: Colors.red),
                Text('300 kcals', style: TextStyle(fontSize: 18))
              ])
            ],
          ),
        ],
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final DetailedActivity widget;

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.all(24),
            child: Column(
              children: [
                Row(children: [
                  Text(
                    Activity.getDateWithDayOfWeek(widget.activity),
                    style: TextStyle(fontSize: 12),
                  )
                ]),
                Row(children: [
                  Text(
                    widget.activity.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ]),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Icon(
                getIconByActivity(widget.activity),
                size: 50,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class AppbarActivityWidget extends StatelessWidget with PreferredSizeWidget {
  const AppbarActivityWidget({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final DetailedActivity widget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: Colors.white,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.share),
          color: Colors.black87,
          tooltip: 'Show Snackbar',
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    PublishActivity(activity: widget.activity)));
          },
        ),
        IconButton(
          icon: const Icon(Icons.edit),
          tooltip: 'Go to the next page',
          color: Colors.black87,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditActivity(activity: widget.activity)));
          },
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          color: Colors.black87,
          onPressed: () {
            ActivityDatabaseManager.instance.remove(widget.activity.id!);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HistoryPage()));
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
