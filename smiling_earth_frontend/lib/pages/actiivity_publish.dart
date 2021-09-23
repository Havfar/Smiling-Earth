import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/models/activity.dart';
import 'package:smiling_earth_frontend/utils/activity_util.dart';

class PublishActivity extends StatefulWidget {
  final Activity activity;
  final urlImage =
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

  const PublishActivity({required this.activity});

  @override
  _publishState createState() => _publishState();
}

class _publishState extends State<PublishActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: buildActivityCard(widget: widget),
    );
  }
}

class buildActivityCard extends StatelessWidget {
  const buildActivityCard({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final PublishActivity widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Publish Activity',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          Card(
            margin: EdgeInsets.only(top: 15),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(widget.urlImage)),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'John Doe',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(widget.activity.start_date)
                              ]),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(widget.activity.title,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(getIconByActivity(widget.activity), size: 50),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.cloud_circle),
                              Text('saved 130kg Co2 compared to Flying')
                            ],
                          ),
                          Text('Duration 6h 34min')
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          TextButton(onPressed: () => print('heyo'), child: Text('Publish'))
        ],
      ),
    );
  }
}
