import 'package:flutter/material.dart';

class HelpWidget extends StatelessWidget {
  final String title;
  final String content;
  const HelpWidget({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text(title),
                  content: Text(content),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                )),
        icon: Icon(Icons.help, color: Colors.blue.shade700));
  }
}
