import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/models/activity.dart';
import 'package:smiling_earth_frontend/pages/history_page.dart';
import 'package:smiling_earth_frontend/utils/activity_util.dart';
import 'package:smiling_earth_frontend/utils/services/database.dart';
import 'package:smiling_earth_frontend/widgets/button_widget.dart';
import 'package:smiling_earth_frontend/widgets/dropdown_select.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

class NewActivity extends StatefulWidget {
  @override
  _newActivityState createState() => _newActivityState();
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

class _newActivityState extends State<NewActivity> {
  final formKey = GlobalKey<FormState>();
  String title = "";
  DateTime date = DateTime.now();
  String dateInt = "0";
  String duration = "0";
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
      ),
      drawer: NavigationDrawerWidget(),
      body: Form(
        key: formKey,
        child: ListView(padding: EdgeInsets.all(16), children: [
          buildTitle(),
          const SizedBox(height: 16),
          buildActivityType(),
          const SizedBox(height: 16),
          buildDuration(),
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
        initialDate: DateTime.now(),
        onDateSaved: (value) =>
            setState(() => dateInt = value.millisecondsSinceEpoch.toString()),
      );

  Widget buildDuration() => TextFormField(
        initialValue: '22',
        decoration: InputDecoration(
          labelText: 'Duration',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        maxLength: 4,
        onSaved: (value) => setState(() => duration = value!),
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
                  start_time: "1909",
                  start_date: "2021-09-11",
                  end_time: "2209",
                  end_date: "2021-09-11",
                  type: type.indexValue);

              DatabaseHelper.instance.add(act);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HistoryPage()));
            }
          },
        ),
      );
}
