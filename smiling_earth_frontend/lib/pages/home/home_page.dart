import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:smiling_earth_frontend/bloc/login/dao/UserDao.dart';
import 'package:smiling_earth_frontend/cubit/notifications/notifications_cubit.dart';
import 'package:smiling_earth_frontend/cubit/posts/post_cubit.dart';
import 'package:smiling_earth_frontend/models/post.dart';
import 'package:smiling_earth_frontend/models/user.dart';
import 'package:smiling_earth_frontend/pages/emission_estimation/emission_estimation.dart';
import 'package:smiling_earth_frontend/pages/home/home_screen_helper.dart';
import 'package:smiling_earth_frontend/pages/notification_page.dart';
import 'package:smiling_earth_frontend/pages/post_add_new.dart';
import 'package:smiling_earth_frontend/utils/services/local_notifications_service.dart';
import 'package:smiling_earth_frontend/utils/services/settings_db_manager.dart';
import 'package:smiling_earth_frontend/widgets/emission_chart.dart';
import 'package:smiling_earth_frontend/widgets/emission_header.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';
import 'package:smiling_earth_frontend/widgets/post_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // callbackDispatcherTest();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green),
        backgroundColor: Colors.white,
      ),
      drawer: NavigationDrawerWidget(),
      body: Container(
        height: 800,
        margin: EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
                child: BlocProvider(
              create: (context) => NotificationsCubit()..getNotificationCount(),
              child: BuildNotificationBell(),
            )),
            BuildHeaderToolbar(
              distance: null,
              electricity: null,
              kcal: null,
              money: null,
              time: null,
            ),
            BuildChart(),
            TextButton.icon(
              onPressed: () => SettingsDatabaseManager.instance.delete(),
              label: Text("delete settings"),
              icon: Icon(Icons.delete),
            ),
            TextButton.icon(
                onPressed: () async =>
                    await NotificationService().showNotifications(),
                label: Text("show notification"),
                icon: Icon(Icons.notification_add)),
            BuildEmissionEstimation(),
            BuildFeed(),
          ],
        ),
      ),
    );
  }
}

class BuildNotificationBell extends StatelessWidget {
  const BuildNotificationBell({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        if (state is NotificationCountRetrived && state.notificaitonCount > 0) {
          return IconButton(
              iconSize: 30,
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NotificationsPage(),
                  )),
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    child: Icon(Icons.notifications_active,
                        color: Colors.grey.shade900),
                  ),
                  Positioned(
                    top: 20,
                    left: 17,
                    width: 20,
                    height: 20,
                    child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade100),
                            color: Colors.deepOrangeAccent),
                        child: Text(state.notificaitonCount.toString())),
                  ),
                ],
              ));
        }
        return IconButton(
            iconSize: 30,
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NotificationsPage(),
                )),
            icon: Icon(Icons.notifications),
            color: Colors.grey.shade900);
      },
    );
  }
}

class BuildChart extends StatelessWidget {
  const BuildChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double emissionGoal = 50;
    return Container(
      child: Column(children: [
        Row(
          children: [
            Text("Emissions",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                )),
          ],
        ),
        FutureBuilder<ChartData>(
          future: getChartDataByMonth(DateTime.now()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: SmilingEarthEmissionChart(
                    energyEmission: snapshot.data!.energy,
                    transportEmission: snapshot.data!.transport,
                    goal: emissionGoal),
              );
            }
            return SkeletonAnimation(
                // borderRadius: BorderRadius.circular(10.0),
                shimmerColor: Colors.white38,
                shimmerDuration: 4000,
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        child: SmilingEarthChartSkeleton()),
                    Text("Loading..",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ));
          },
        ),
      ]),
    );
  }
}

class BuildFeed extends StatefulWidget {
  const BuildFeed({
    Key? key,
  }) : super(key: key);

  @override
  State<BuildFeed> createState() => _BuildFeedState();
}

class _BuildFeedState extends State<BuildFeed> {
  late Future<User?> user;
  late Future<PostDto> postsdto;

  @override
  void initState() {
    super.initState();
    this.user = UserDao().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "Feed",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          TextButton.icon(
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewPostPage()),
                  ),
              icon: Icon(Icons.add),
              label: Text("Add"))
        ]),
        BlocProvider<PostCubit>(
            create: (context) => PostCubit()..getPosts(),
            child: BuildPostsFeed()),
      ]),
    );
  }
}

class BuildPostsFeed extends StatelessWidget {
  const BuildPostsFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100000,
      child: BlocBuilder<PostCubit, PostState>(builder: (context, state) {
        if (state is PostRetrived) {
          return SingleChildScrollView(
            child: ListView.builder(
                itemCount: state.posts.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return PostWidget(
                      clickable: true, liked: false, post: state.posts[index]);
                }),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}

class BuildEmissionEstimation extends StatelessWidget {
  const BuildEmissionEstimation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 10),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: Colors.black12),
              bottom: BorderSide(color: Colors.black12))),
      child: ListTile(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EmissionEstimatePage()),
        ),
        title: Text("See how to reduce your emissions"),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}
