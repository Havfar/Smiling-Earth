import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/posts/post_cubit.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_about.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_challenges.dart';
import 'package:smiling_earth_frontend/pages/teams/teams_detailed.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';
import 'package:smiling_earth_frontend/widgets/post_widget.dart';

class TeamPosts extends StatelessWidget {
  final int? id;
  TeamPosts({required this.id});

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        // builder: (BuildContext context) => TeamsDetailedPage(id: id),
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              TeamsDetailedPage(id: id),
          transitionDuration: Duration.zero,
        ));
        break;
      case 1:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              TeamPosts(id: id),
          transitionDuration: Duration.zero,
        ));
        break;
      case 2:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              TeamChallenges(teamId: id),
          transitionDuration: Duration.zero,
        ));
        break;
      case 3:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              TeamAbout(teamId: id),
          transitionDuration: Duration.zero,
        ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green),
      ),
      drawer: NavigationDrawerWidget(),
      body: Column(
        children: [
          BlocProvider<PostCubit>(
              create: (context) => PostCubit()..getTeamPosts(id!),
              child: BuildFeed()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
          type: BottomNavigationBarType.fixed,
          onTap: (
            index,
          ) =>
              _onTap(context, index),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Emissions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.forum_outlined),
              label: 'Posts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events_outlined),
              label: 'Challenges',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'About',
            ),
          ]));
}

class BuildFeed extends StatelessWidget {
  const BuildFeed({
    Key? key,
  }) : super(key: key);

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
          child: Text("Loading"),
        );
      }),
    );
  }
}
