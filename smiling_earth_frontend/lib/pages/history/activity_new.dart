import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/models/activity.dart';
import 'package:smiling_earth_frontend/pages/history/history_page.dart';
import 'package:smiling_earth_frontend/utils/activity_util.dart';
import 'package:smiling_earth_frontend/utils/services/activity_db_manager.dart';
import 'package:smiling_earth_frontend/widgets/button_widget.dart';
import 'package:smiling_earth_frontend/widgets/dropdown_select.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

class NewActivity extends StatefulWidget {
  @override
  NewActivityState createState() => NewActivityState();
}

List<DropdownSelectElement> _createList() {
  var list = <DropdownSelectElement>[];
  for (AppActivityType activityType in AppActivityType.values) {
    list.add(new DropdownSelectElement(
        title: getActivityNameByActivityType(activityType),
        icon: getIconByActivityType(activityType),
        indexValue: activityType.index));
  }
  return list;
}

class NewActivityState extends State<NewActivity> {
  final formKey = GlobalKey<FormState>();
  String title = "";
  DateTime date = DateTime.now();
  String dateInt = "0";
  late String durationHours;
  late String durationMinutes;
  List<DropdownSelectElement> items = _createList();
  DropdownSelectElement type = new DropdownSelectElement(
      title: getActivityNameByActivityType(AppActivityType.IN_CAR),
      icon: getIconByActivityType(AppActivityType.IN_CAR),
      indexValue: 0);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
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
              SizedBox(
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

  Widget buildDatePicker() => InputDatePickerFormField(
        firstDate: DateTime(2020),
        lastDate: DateTime(2022),
        initialDate: DateTime.now(),
        onDateSaved: (value) => setState(() => date = value),
      );

  Widget buildDurationHour() => Expanded(
        child: TextFormField(
          initialValue: "0",
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
          initialValue: "0",
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
          onSaved: (value) => setState(() => durationMinutes = value!),
        ),
      );

  Widget buildSubmit() => Builder(
        builder: (context) => ButtonWidget(
          text: 'Submit',
          onClicked: () {
            final isValid = formKey.currentState!.validate();
            // FocusScope.of(context).unfocus();

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
                  startDate: date,
                  endDate: date.add(Duration(
                      hours: int.tryParse(durationHours)!,
                      minutes: int.tryParse(durationMinutes)!)),
                  type: type.indexValue);

              ActivityDatabaseManager.instance.add(act);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HistoryPage()));
            }
          },
        ),
      );
}
