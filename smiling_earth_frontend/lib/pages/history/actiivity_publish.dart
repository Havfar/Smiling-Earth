import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/activity/activity_cubit.dart';
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
      ),
      body: BlocProvider(
        create: (context) => ActivityCubit(),
        child: buildActivityCard(widget: widget),
      ),
    );
  }
}

class buildActivityCard extends StatelessWidget {
  // final Activity activity;
  const buildActivityCard({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final PublishActivity widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: BlocBuilder<ActivityCubit, ActivityState>(
        builder: (context, state) {
          if (state is ActivityPosted) {
            return Text("Post created: " + state.post.id.toString());
          } else if (state is CreatingActivity) {
            return Text("Loading");
          } else if (state is Error) {
            return Text(
                "Could not post activity try again later. " + state.error);
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Publish Activity',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
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
                                  backgroundImage:
                                      NetworkImage(widget.urlImage)),
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'John Doe',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(Activity.formatDatetime(
                                          widget.activity.start_date))
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
                TextButton(
                    onPressed: () {
                      BlocProvider.of<ActivityCubit>(context)
                          .PublishActivity(widget.activity.toDto());
                    },
                    child: Text('Publish'))
              ],
            );
          }
        },
      ),
    );
  }
}
