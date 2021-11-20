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
            TagWidget(widget.activity.tag),
          ],
        ),
      ),
    );
  }
}

class TagWidget extends StatelessWidget {
  final String? tag;
  const TagWidget(
    this.tag, {
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
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: tag == null ? Colors.white : Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(tag == null ? 'No tag' : tag!),
          )
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
      padding: EdgeInsets.only(top: 40, bottom: 40),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: Colors.black12),
              bottom: BorderSide(color: Colors.black12))),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Column(children: [
                Text(
                  'Emitted ☁️',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 15),
                Text(
                  '${widget.activity.getEmission().roundToDouble()} kg Co2',
                  style: TextStyle(fontSize: 18),
                )
              ])
            ],
          ),
          Column(
            children: [
              Column(children: [
                Text(
                  'Burned 🔥',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 15),
                Text('${widget.activity.getCalories().roundToDouble()} kcals',
                    style: TextStyle(fontSize: 18))
              ])
            ],
          ),
          Column(
            children: [
              Column(children: [
                Text(
                  'Saved 💰',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 15),
                Text('${widget.activity.getMoneySaved().roundToDouble()} kr',
                    style: TextStyle(fontSize: 18))
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
