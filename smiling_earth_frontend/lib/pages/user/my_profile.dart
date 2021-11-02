import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/pledge/pledge_cubit.dart';
import 'package:smiling_earth_frontend/cubit/posts/post_cubit.dart';
import 'package:smiling_earth_frontend/cubit/user/profile_cubit.dart';
import 'package:smiling_earth_frontend/pages/user/profile_page.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({Key? key}) : super(key: key);
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
                create: (context) => ProfileCubit()..getMyProfile(),
                child: _BuildHeader(),
              ),
              BlocProvider(
                create: (context) => PledgeCubit()..getMyUserPledges(),
                child: BuildPledges(),
              ),
              BlocProvider(
                create: (context) => PostCubit()..getMyPosts(),
                child: BuildFeed(),
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
                  //  Container(
                  //       height: 60,
                  //       width: 60,
                  //       padding: EdgeInsets.all(5),
                  //       decoration: BoxDecoration(
                  //         color: Colors.grey.shade200,
                  //         shape: BoxShape.circle,
                  //       ),
                  //       child: Avatar.toSvg(widget.post.user!.avatar!))
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
                      SizedBox(height: 10),
                      Container(width: 250, child: Text(state.profile.bio)),
                      SizedBox(height: 10),
                      Row(children: [
                        Container(
                          padding: EdgeInsets.only(right: 25),
                          child: Column(
                            children: [
                              Text(state.profile.followerCount.toString()),
                              Text('Followers'),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 25),
                          child: Column(
                            children: [
                              Text(state.profile.followingCount.toString()),
                              Text('Following'),
                            ],
                          ),
                        ),
                      ])
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
