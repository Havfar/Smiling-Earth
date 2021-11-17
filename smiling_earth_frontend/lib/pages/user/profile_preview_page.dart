import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/user/follow_cubit.dart';
import 'package:smiling_earth_frontend/cubit/user/profile_cubit.dart';
import 'package:smiling_earth_frontend/pages/user/profile_page.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

class ProfilePreviewPage extends StatelessWidget {
  final int userId;

  const ProfilePreviewPage({Key? key, required this.userId}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.green),
        ),
        drawer: NavigationDrawerWidget(),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Card(
            child: Container(
              height: 180,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  BlocProvider(
                    create: (context) =>
                        ProfileCubit()..getProfile(this.userId),
                    child: BuildProfileHeader(),
                  ),
                  BlocProvider(
                    create: (context) => FollowCubit(),
                    child: BlocBuilder<FollowCubit, FollowState>(
                      builder: (context, state) {
                        if (state is FollowRequestSending) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is FollowRequestApproved) {
                          return Column(
                            children: [
                              SizedBox(height: 5),
                              Text('Following!'),
                              SizedBox(height: 5),
                              ElevatedButton(
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProfilePage(
                                              userId: this.userId))),
                                  child: Text('Visit Profile')),
                            ],
                          );
                        } else if (state is FollowRequestError) {
                          return Text(
                              'An error occured. Please try again later');
                        }
                        return ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<FollowCubit>(context)
                                  .follow(this.userId);
                            },
                            child: Text('follow'));
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
