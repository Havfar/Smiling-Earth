import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:smiling_earth_frontend/cubit/user/user_cubit.dart';
import 'package:smiling_earth_frontend/models/avatar.dart';
import 'package:smiling_earth_frontend/pages/user/profile_page.dart';
import 'package:smiling_earth_frontend/pages/user/profile_preview_page.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

class FollowerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.green),
        ),
        drawer: NavigationDrawerWidget(),
        body: ListView(
          children: [
            BlocProvider(
              create: (context) => UserCubit()..getFollowers(),
              child: _BuildFollowers(),
            ),
            BlocProvider(
              create: (context) => UserCubit()..getFollowing(),
              child: _BuildFollowing(),
            ),
            BlocProvider(
              create: (context) => UserCubit()..getNotFollowing(),
              child: _BuildFindUsers(),
            )
          ],
        ),
      );
}

class _BuildFindUsers extends StatelessWidget {
  const _BuildFindUsers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(top: 20, bottom: 10, left: 10),
            child: Text("New people",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ))),
        _BuildList()
      ],
    );
  }
}

class _BuildLoadingTile extends StatelessWidget {
  const _BuildLoadingTile({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<int> list = [1, 2, 3, 4];
    return Column(
        children: list
            .map(
              (e) => SkeletonAnimation(
                borderRadius: BorderRadius.circular(10.0),
                shimmerColor: Colors.white38,
                shimmerDuration: 3000,
                child: Container(
                  // padding: EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.black12))),
                  child: ListTile(
                    leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey, shape: BoxShape.circle)),
                    title: Container(
                        width: 100,
                        height: 15,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                        )),
                  ),
                ),
              ),
            )
            .toList());
  }
}

class _BuildFollowing extends StatelessWidget {
  const _BuildFollowing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(top: 20, bottom: 10, left: 10),
            child: Text("Following",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ))),
        _BuildList()
      ],
    );
  }
}

class _BuildFollowers extends StatelessWidget {
  const _BuildFollowers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 10, left: 10),
          child: Text("Followers",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              )),
        ),
        _BuildList()
      ],
    );
  }
}

class _BuildList extends StatelessWidget {
  const _BuildList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border(top: BorderSide(color: Colors.black12))),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UsersRetrived) {
            return Column(
                children: state.users
                    .map((user) => (Container(
                          // padding: EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black12))),
                          child: ListTile(
                              //               Navigator.push(
                              // context,
                              // MaterialPageRoute(
                              //     builder: (context) => this.showJoinButton
                              //         ? TeamPreview(id: team.id)
                              //         : TeamsDetailedPage(id: team.id))
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => user.isFollowing
                                            ? ProfilePage(
                                                userId: user.user.userId)
                                            : ProfilePreviewPage(
                                                userId: user.user.userId)));
                              },
                              leading: Container(
                                  height: 60,
                                  width: 60,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Avatar.toSvg(user.user.avatar!)),
                              title: Text(user.user.getName()),
                              trailing: user.isFollowing
                                  ? TextButton(
                                      child: Text('Following'),
                                      onPressed: () => print('ok'),
                                    )
                                  : ElevatedButton(
                                      onPressed: () => print('lol'),
                                      child: Text('Follow'))),
                        )))
                    .toList());
          } else if (state is UsersRetrivedError) {
            return Text('Error' + state.error);
          }
          return _BuildLoadingTile();
        },
      ),
    );
  }
}
