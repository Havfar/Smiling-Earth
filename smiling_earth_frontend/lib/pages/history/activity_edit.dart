import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/models/activity.dart';
import 'package:smiling_earth_frontend/utils/activity_util.dart';
import 'package:smiling_earth_frontend/utils/services/activity_db_manager.dart';
import 'package:smiling_earth_frontend/widgets/button_widget.dart';
import 'package:smiling_earth_frontend/widgets/dropdown_select.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

import 'history_page.dart';

class EditActivity extends StatefulWidget {
  final Activity activity;

  const EditActivity({required this.activity});

  @override
  _EditActivityState createState() => _EditActivityState();
}

List<DropdownSelectElement> _createList() {
  var list = <DropdownSelectElement>[];
  for (AppActivityType activityType in getTransportationTypes()) {
    list.add(new DropdownSelectElement(
        title: getTransporationNameByActivityType(activityType),
        icon: getIconByActivityType(activityType),
        indexValue: activityType.index));
  }
  return list;
}

List<DropdownSelectElement> _createTags() {
  var list = <DropdownSelectElement>[];
  int counter = 0;
  for (String tag in getActivityTags()) {
    list.add(new DropdownSelectElement(
        title: tag, icon: getActivityTagsIcon(tag), indexValue: counter));
    counter++;
  }
  return list;
}

class _EditActivityState extends State<EditActivity> {
  final formKey = GlobalKey<FormState>();
  String title = '';
  late DateTime date;
  late String dateInt;
  late String durationHours;
  late String durationMinute;

  List<DropdownSelectElement> items = _createList();
  List<DropdownSelectElement> tags = _createTags();

  late DropdownSelectElement type;

  late DropdownSelectElement tag;

  @override
  void initState() {
    date = widget.activity.startDate == null
        ? DateTime.now()
        : widget.activity.startDate!;
    durationHours = widget.activity.getTotalDurationInHours().toString();
    durationMinute =
        (widget.activity.getTotalDurationInMinutes() % 60).toString();
    type = items.first;
    tag = tags.first;
    super.initState();
  }

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
          buildTag(),
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
        onChanged: (value) => setState(() => title = value),
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
            type = newValue!;
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

  Widget buildTag() => DropdownButtonFormField<DropdownSelectElement>(
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        onSaved: (value) => setState(() => tag = value!),
        onChanged: (DropdownSelectElement? newValue) {
          setState(() {
            tag = newValue!;
          });
        },
        items: tags.map<DropdownMenuItem<DropdownSelectElement>>(
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
          labelText: 'Tag (optional)',
          border: OutlineInputBorder(),
        ),
      );

  Widget buildDatePicker() => InputDatePickerFormField(
        firstDate: DateTime(2020),
        lastDate: DateTime(2022),
        initialDate: new DateTime.now(),
        onDateSaved: (value) => setState(() => date = value),
      );

  Widget buildDurationHour() => Expanded(
        child: TextFormField(
          initialValue: durationHours,
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
          onChanged: (value) => setState(() => durationHours = value),
        ),
      );

  Widget buildDurationMinutes() => Expanded(
        child: TextFormField(
          initialValue: durationMinute,
          decoration: InputDecoration(
            labelText: 'Minutes',
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
            } else if (valueInt > 59) {
              return 'Must be less than 60';
            } else if (valueInt < 0) {
              return 'Must be a positive number';
            }
          },
          onChanged: (value) => setState(() => durationMinute = value),
        ),
      );

  Widget buildSubmit() => Builder(
        builder: (context) => ButtonWidget(
          text: 'Submit',
          onClicked: () {
            final isValid = formKey.currentState!.validate();

            if (isValid) {
              final message = 'Activity Updated';
              final snackBar = SnackBar(
                content: Text(
                  message,
                  style: TextStyle(fontSize: 20),
                ),
                backgroundColor: Colors.green,
              );
              int hours = durationHours == '' ? 0 : int.parse(durationHours);
              int minutes =
                  durationMinute == '' ? 0 : int.parse(durationMinute);
              Activity act = new Activity(
                  title: title != '' ? title : widget.activity.title,
                  startDate: date,
                  endDate: date.add(Duration(hours: hours, minutes: minutes)),
                  type: type.indexValue,
                  id: widget.activity.id,
                  tag: tag.title != '' ? tag.title : null);

              print('tag: ${tag.title}');
              print('type: $type');
              ActivityDatabaseManager.instance.update(act);
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HistoryPage()));
            }
          },
        ),
      );
}
