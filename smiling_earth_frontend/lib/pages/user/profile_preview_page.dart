import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              height: 150,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  BlocProvider(
                    create: (context) =>
                        ProfileCubit()..getProfile(this.userId),
                    child: BuildProfileHeader(),
                  ),
                  ElevatedButton(
                      onPressed: () => print(''), child: Text('follow'))
                ],
              ),
            ),
          ),
        ),
      );
}
