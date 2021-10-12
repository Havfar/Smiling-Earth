import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/user/profile_cubit.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

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
        body: ListView(
          children: [
            BlocProvider(
              create: (context) => ProfileCubit()..getProfile(this.userId),
              child: _BuildHeader(),
            ),
            _BuildPledges(),
            _BuildAchievements(),
            _BuildTeamsList(),
            _BuildFeed()
          ],
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
          return Text(state.profile.firstName);
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
    return Text('Pledges');
  }
}

class _BuildAchievements extends StatelessWidget {
  const _BuildAchievements({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Thropies');
  }
}

class _BuildTeamsList extends StatelessWidget {
  const _BuildTeamsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Teams');
  }
}

class _BuildFeed extends StatelessWidget {
  const _BuildFeed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Feed');
  }
}
