import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:smiling_earth_frontend/cubit/posts/post_cubit.dart';
import 'package:smiling_earth_frontend/cubit/teams/teams_cubit.dart';
import 'package:smiling_earth_frontend/cubit/user/profile_cubit.dart';
import 'package:smiling_earth_frontend/widgets/circle_icon.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';
import 'package:smiling_earth_frontend/widgets/post_widget.dart';

class ProfilePage extends StatelessWidget {
  final int userId;

  const ProfilePage({Key? key, required this.userId}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.green),
        ),
        drawer: NavigationDrawerWidget(),
        body: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              BlocProvider(
                create: (context) => ProfileCubit()..getProfile(this.userId),
                child: _BuildHeader(),
              ),
              _BuildPledges(),
              _BuildAchievements(),
              BlocProvider(
                create: (context) =>
                    TeamsCubit()..getUserIsMemberOf(this.userId),
                child: _BuildTeamsList(),
              ),
              BlocProvider(
                create: (context) => PostCubit()..getUserPosts(this.userId),
                child: _BuildFeed(),
              )
            ],
          ),
        ),
      );
}

class _BuildHeader extends StatelessWidget {
  const _BuildHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileRetrived) {
          return Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(state.profile.image)),
                  SizedBox(width: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(state.profile.getName(),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      Text('200 kg CO2 /day',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.green)),
                      Container(
                        width: 250,
                        child: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam sed diam sem. Curabitur at nisi ut sem euismod.'),
                      )
                    ],
                  ),
                ],
              ),
            ],
          );
        } else if (state is ProfileRetrivedError) {
          return Text('Error: ' + state.error);
        }
        return Text('Loading');
      },
    );
  }
}

class _BuildPledges extends StatelessWidget {
  const _BuildPledges({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('I pledge to',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          SkeletonAnimation(
              // borderRadius: BorderRadius.circular(10.0),
              shimmerColor: Colors.white38,
              shimmerDuration: 4000,
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    CircleIconSkeleton(),
                    SizedBox(width: 20),
                    CircleIconSkeleton(),
                    SizedBox(width: 20),
                    CircleIconSkeleton(),
                    SizedBox(width: 20),
                    CircleIconSkeleton(),
                    SizedBox(width: 20),
                    CircleIconSkeleton(),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class _BuildAchievements extends StatelessWidget {
  const _BuildAchievements({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Completed Challenges',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        SkeletonAnimation(
            // borderRadius: BorderRadius.circular(10.0),
            shimmerColor: Colors.white38,
            shimmerDuration: 4000,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  CircleIconSkeleton(),
                  SizedBox(width: 20),
                  CircleIconSkeleton(),
                  SizedBox(width: 20),
                  CircleIconSkeleton(),
                  SizedBox(width: 20),
                  CircleIconSkeleton(),
                  SizedBox(width: 20),
                  CircleIconSkeleton(),
                ],
              ),
            ))
      ],
    ));
  }
}

class _BuildTeamsList extends StatelessWidget {
  const _BuildTeamsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Joined Teams',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        BlocBuilder<TeamsCubit, TeamsState>(
          builder: (context, state) {
            if (state is RetrievedTeams) {
              return Row(
                  children: state.teams
                      .map((team) => Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Column(
                              children: [
                                CircleIcon(
                                  emoji: team.symbol,
                                  backgroundColor: Colors.blueAccent,
                                ),
                                SizedBox(height: 5),
                                Text(team.name, style: TextStyle(fontSize: 10)),
                              ],
                            ),
                          ))
                      .toList());
            }
            return Column(
              children: [
                SkeletonAnimation(
                    shimmerColor: Colors.white38,
                    shimmerDuration: 4000,
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          CircleIconSkeleton(),
                          SizedBox(width: 20),
                          CircleIconSkeleton(),
                          SizedBox(width: 20),
                          CircleIconSkeleton(),
                          SizedBox(width: 20),
                          CircleIconSkeleton(),
                          SizedBox(width: 20),
                          CircleIconSkeleton(),
                          SizedBox(width: 20),
                          CircleIconSkeleton(),
                        ],
                      ),
                    ))
              ],
            );
          },
        ),
      ],
    );
  }
}

class _BuildFeed extends StatelessWidget {
  const _BuildFeed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Posts',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          BlocBuilder<PostCubit, PostState>(
            builder: (context, state) {
              if (state is PostRetrived) {
                return Column(
                    children: state.posts
                        .map((post) => PostWidget(
                            post: post, liked: false, clickable: true))
                        .toList());
              } else if (state is PostError) {
                return Text(state.error);
              }
              return Column(
                children: [
                  PostSkeletonWidget(),
                  PostSkeletonWidget(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
