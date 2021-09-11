import 'package:flutter/material.dart';

class DropdownSelectElement {
  final String title;
  final IconData icon;
  final int indexValue;

  DropdownSelectElement(
      {required this.title, required this.icon, required this.indexValue});

  @override
  String toString() {
    return title;
  }
}

class DropdownSelect extends StatefulWidget {
  final DropdownSelectElement selectedIndex;
  final List<DropdownSelectElement> items;
  final void onSaved;

  const DropdownSelect(
      {required this.selectedIndex,
      required this.items,
      required void Function(int value) this.onSaved});

  @override
  _dropdownState createState() => _dropdownState();
}

class _dropdownState extends State<DropdownSelect> {
  late DropdownSelectElement dropdownValue;

  @override
  Widget build(BuildContext context) {
    dropdownValue = widget.selectedIndex;
    return DropdownButtonFormField<DropdownSelectElement>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (DropdownSelectElement? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      // onSaved: (dropdowValue) {
      //   () => widget.onSaved(dropdownValue.indexValue);
      // },
      items: widget.items.map<DropdownMenuItem<DropdownSelectElement>>(
          (DropdownSelectElement element) {
        return DropdownMenuItem<DropdownSelectElement>(
            value: element,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(element.icon),
                SizedBox(width: 10),
                Text(element.title),
              ],
            ));
      }).toList(),
      decoration: InputDecoration(
        labelText: 'Title',
        border: OutlineInputBorder(),
      ),
    );
  }
}
