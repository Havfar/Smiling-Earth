import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:smiling_earth_frontend/cubit/activity/activity_cubit.dart';
import 'package:smiling_earth_frontend/models/activity.dart';
import 'package:smiling_earth_frontend/pages/home/home_page.dart';
import 'package:smiling_earth_frontend/utils/activity_util.dart';
import 'package:smiling_earth_frontend/widgets/user_name_widget.dart';

class PublishActivity extends StatefulWidget {
  final Activity activity;
  const PublishActivity({required this.activity});

  @override
  PublishState createState() => PublishState();
}

class PublishState extends State<PublishActivity> {
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
        child: BuildActivityCard(widget: widget),
      ),
    );
  }
}

class BuildActivityCard extends StatelessWidget {
  // final Activity activity;
  const BuildActivityCard({
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
            return Center(
                child: Column(
              children: [
                SizedBox(height: 50),
                Text("Post created!",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                SizedBox(height: 30),
                ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePage())),
                    child: Text('Go to home screen'))
              ],
            ));
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
                              Container(
                                  width: 50,
                                  height: 50,
                                  child: FluttermojiCircleAvatar()),
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BuildLocalName(),
                                      Text(Activity.formatDatetime(
                                          widget.activity.startDate))
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
                                Text(Activity.formatDuration(widget.activity)),
                                SizedBox(height: 5),
                                Text(
                                    '☁️ Emitted: ${widget.activity.getEmission().round()} kgCO2'),
                                Text(
                                    '🔥 Burned: ${widget.activity.getCalories().round()} kcals'),
                                Text(
                                    '💰 Saved: ${widget.activity.getMoneySaved().round()} kr '),
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
                          .publishActivity(widget.activity.toDto());
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
