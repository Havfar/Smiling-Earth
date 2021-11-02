import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:fluttermoji/fluttermojiCustomizer.dart';
import 'package:get/get.dart';
import 'package:smiling_earth_frontend/cubit/user/avatar_cubit.dart';
import 'package:smiling_earth_frontend/models/avatar.dart';
import 'package:smiling_earth_frontend/pages/registration/house_registration.dart';
import 'package:smiling_earth_frontend/pages/registration/user_information.dart';
import 'package:smiling_earth_frontend/widgets/page_indicator.dart';

class AvatarRegistrationPage extends StatefulWidget {
  @override
  State<AvatarRegistrationPage> createState() => _AvatarRegistrationPageState();
}

class _AvatarRegistrationPageState extends State<AvatarRegistrationPage> {
  List<int> selectedPledges = [];
  bool sendtPledgeRequest = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        // appBar: AppBar(),
        // drawer: NavigationDrawerWidget(),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: FluttermojiCircleAvatar(
                radius: 100,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
              child: FluttermojiCustomizer(
                outerTitleText: 'Create your avatar',
                //scaffoldHeight: 400,
                showSaveWidget: false,
              ),
            ),
          ],
        ),
        bottomNavigationBar: sendtPledgeRequest
            ? null
            : PageIndicator(
                index: 3,
                previousPage: MaterialPageRoute(
                    builder: (context) => UserInformationRegistration()),
                nextPage: MaterialPageRoute(
                    builder: (context) => HouseRegistrationPage()),
                formSumbissionFunction: () => submitPledges(context)),
      );

  void submitPledges(BuildContext context) {
    var _fluttermojiController = Get.find<FluttermojiController>();
    _fluttermojiController.setFluttermoji();
    Avatar avatar = Avatar.fromJson(_fluttermojiController.selectedIndexes);
    AvatarCubit()..updateAvatar(avatar);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HouseRegistrationPage()));
  }
}
