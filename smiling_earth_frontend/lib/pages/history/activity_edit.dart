import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/models/activity.dart';
import 'package:smiling_earth_frontend/pages/history/activity_detailed.dart';
import 'package:smiling_earth_frontend/utils/activity_util.dart';
import 'package:smiling_earth_frontend/utils/services/database.dart';
import 'package:smiling_earth_frontend/widgets/button_widget.dart';
import 'package:smiling_earth_frontend/widgets/dropdown_select.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

class EditActivity extends StatefulWidget {
  final Activity activity;

  const EditActivity({required this.activity});

  @override
  _editActivityState createState() => _editActivityState();
}

List<DropdownSelectElement> _createList() {
  var list = <DropdownSelectElement>[];
  for (ActivityType activityType in ActivityType.values) {
    list.add(new DropdownSelectElement(
        title: getActivityNameByActivityType(activityType),
        icon: getIconByActivityType(activityType),
        indexValue: activityType.index));
  }
  return list;
}

class _editActivityState extends State<EditActivity> {
  final formKey = GlobalKey<FormState>();
  late String title;
  late DateTime date;
  late String dateInt;
  late String durationHours;
  late String durationMinute;

  List<DropdownSelectElement> items = _createList();
  DropdownSelectElement type = new DropdownSelectElement(
      title: getActivityNameByActivityType(ActivityType.IN_CAR),
      icon: getIconByActivityType(ActivityType.IN_CAR),
      indexValue: 0);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
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
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Go to the next page',
            color: Colors.black87,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Next page'),
                    ),
                    body: const Center(
                      child: Text(
                        'This is the next page',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  );
                },
              ));
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Go to the next page',
            color: Colors.black87,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Next page'),
                    ),
                    body: const Center(
                      child: Text(
                        'This is the next page',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  );
                },
              ));
            },
          ),
        ],
      ),
      drawer: NavigationDrawerWidget(),
      body: Form(
        key: formKey,
        child: ListView(padding: EdgeInsets.all(16), children: [
          buildTitle(),
          const SizedBox(height: 16),
          buildActivityType(),
          const SizedBox(height: 16),
          Row(
            children: [
              buildDurationHour(),
              const SizedBox(
                width: 30,
              ),
              buildDurationMinutes()
            ],
          ),
          const SizedBox(height: 16),
          buildDatePicker(),
          const SizedBox(height: 16),
          const SizedBox(height: 16),
          buildSubmit()
        ]),
      ));

  Widget buildTitle() => TextFormField(
        initialValue: widget.activity.title.toString(),
        decoration: InputDecoration(
          labelText: 'Title',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.length < 1) {
            return 'Enter at least 1 characters';
          } else {
            return null;
          }
        },
        maxLength: 30,
        onSaved: (value) => setState(() => title = value!),
      );

  Widget buildActivityType() => DropdownButtonFormField<DropdownSelectElement>(
        value: items[widget.activity.type.toInt()],
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        onSaved: (value) => setState(() => type = value!),
        onChanged: (DropdownSelectElement? newValue) {
          setState(() {
            print('2 stated changed ' + newValue!.indexValue.toString());
            type = newValue;
          });
        },
        items: items.map<DropdownMenuItem<DropdownSelectElement>>(
            (DropdownSelectElement element) {
          return DropdownMenuItem<DropdownSelectElement>(
              value: element,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(element.icon),
                  SizedBox(width: 5),
                  Text(element.title),
                ],
              ));
        }).toList(),
        decoration: InputDecoration(
          labelText: 'Activity type',
          border: OutlineInputBorder(),
        ),
      );

  Widget buildDatePicker() => InputDatePickerFormField(
        firstDate: DateTime(2020),
        lastDate: DateTime(2022),
        initialDate: new DateTime.now(),
        onDateSaved: (value) =>
            setState(() => dateInt = value.millisecondsSinceEpoch.toString()),
      );

  Widget buildDurationHour() => Expanded(
        child: TextFormField(
          initialValue: Activity.getDurationHours(widget.activity).toString(),
          decoration: InputDecoration(
            labelText: 'Hours',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          maxLength: 2,
          validator: (value) {
            int? valueInt = int.tryParse(value!);
            if (value.length < 1) {
              return 'Enter at least 1 characters';
            } else if (valueInt == null) {
              return 'Enter a number';
            } else if (valueInt > 24) {
              return 'Must be less than 24';
            } else if (valueInt < 0) {
              return 'Must be a positive number';
            }
          },
          onSaved: (value) => setState(() => durationHours = value!),
        ),
      );

  Widget buildDurationMinutes() => Expanded(
        child: TextFormField(
          initialValue: Activity.getDurationMinutes(widget.activity).toString(),
          decoration: InputDecoration(
            labelText: 'Minutes',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          maxLength: 2,
          validator: (value) {
            print(value);
            int? valueInt = int.tryParse(value!);
            if (value.length < 1) {
              return 'Enter at least 1 characters';
            } else if (valueInt == null) {
              return 'Enter a number';
            } else if (valueInt > 59) {
              return 'Must be less than 60';
            } else if (valueInt < 0) {
              return 'Must be a positive number';
            }
          },
          onSaved: (value) => setState(() => durationMinute = value!),
        ),
      );

  Widget buildSubmit() => Builder(
        builder: (context) => ButtonWidget(
          text: 'Submit',
          onClicked: () {
            final isValid = formKey.currentState!.validate();

            if (isValid) {
              formKey.currentState!.save();

              final message = 'Username: havfar \nPassword:';
              final snackBar = SnackBar(
                content: Text(
                  message,
                  style: TextStyle(fontSize: 20),
                ),
                backgroundColor: Colors.green,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Activity act = new Activity(
                  title: title,
                  start_date: widget.activity.start_date,
                  end_date: widget.activity.end_date,
                  type: type.indexValue,
                  id: widget.activity.id);

              DatabaseHelper.instance.update(act);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      DetailedActivity(activity: widget.activity)));
            }
          },
        ),
      );
}
