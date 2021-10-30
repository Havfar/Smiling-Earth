import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int index;
  final MaterialPageRoute? previousPage;
  final MaterialPageRoute? nextPage;

  _getTextButton(BuildContext context, String title, MaterialPageRoute? route) {
    if (route == null) {
      return Text(title,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey));
    }
    return TextButton(
        onPressed: () => Navigator.of(context).push(route!),
        child: Text(title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)));
  }

  const PageIndicator(
      {Key? key,
      required this.index,
      required this.previousPage,
      required this.nextPage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double _size = 15;
    final double _margin = 10;
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        _getTextButton(context, 'Previous', previousPage),
        SizedBox(width: 30),
        Container(
            margin: EdgeInsets.only(right: _margin),
            height: _size,
            width: _size,
            decoration: BoxDecoration(
                color: index == 0 ? Colors.blue.shade400 : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20))),
        Container(
            margin: EdgeInsets.only(right: _margin),
            height: _size,
            width: _size,
            decoration: BoxDecoration(
                color: index == 1 ? Colors.blue.shade400 : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20))),
        Container(
            margin: EdgeInsets.only(right: _margin),
            height: _size,
            width: _size,
            decoration: BoxDecoration(
                color: index == 2 ? Colors.blue.shade400 : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20))),
        Container(
            margin: EdgeInsets.only(right: _margin),
            height: _size,
            width: _size,
            decoration: BoxDecoration(
                color: index == 3 ? Colors.blue.shade400 : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20))),
        Container(
            height: _size,
            width: _size,
            decoration: BoxDecoration(
                color: index == 4 ? Colors.blue.shade400 : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20))),
        SizedBox(width: 30),
        _getTextButton(context, 'Next', nextPage),
      ]),
    );
  }
}