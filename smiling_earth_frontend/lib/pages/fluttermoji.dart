import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:get/get.dart';
import 'package:smiling_earth_frontend/cubit/user/avatar_cubit.dart';
import 'package:smiling_earth_frontend/models/avatar.dart';

class FlutterMojiPage extends StatefulWidget {
  final String title;
  FlutterMojiPage({Key? key, required this.title}) : super(key: key);

  @override
  _FlutterMojiPageState createState() => _FlutterMojiPageState();
}

class _FlutterMojiPageState extends State<FlutterMojiPage> {
  bool saved = false;
  late Avatar avatar;
  // final Map<String, dynamic> emoji =
  final Map<String?, dynamic> emoji = {
    "topType": 20,
    "accessoriesType": 1,
    "hairColor": 3,
    "facialHairType": 1,
    "facialHairColor": 3,
    "clotheType": 2,
    "eyeType": 2,
    "eyebrowType": 10,
    "mouthType": 8,
    "skinColor": 4,
    "clotheColor": 2,
    "style": 0,
    "graphicType": 0
  };
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: FluttermojiCircleAvatar(
              radius: 100,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: FluttermojiCustomizer(
              outerTitleText: '',
              //scaffoldHeight: 400,
              showSaveWidget: false,
            ),
          ),
          getSaveButton()
        ],
      ),
    );
  }

  Container getSaveButton() {
    if (saved) {
      return Container(
        child: BlocProvider(
          create: (context) => AvatarCubit()..updateAvatar(avatar),
          child: BlocBuilder<AvatarCubit, AvatarState>(
            builder: (context, state) {
              if (state is AvatarUpdated) {
                return Center(child: Text('Avatar is updated'));
              } else if (state is AvatarError) {
                return Text('Error ' + state.error);
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      );
    } else {
      return Container(
        child: ElevatedButton(
            onPressed: () => submitAvatar(), child: Text('Save')),
      );
    }
  }

  SvgPicture getEmoji() {
    String svg =
        FluttermojiFunctions().decodeFluttermojifromString(jsonEncode(emoji));
    var s = SvgPicture.string(svg);
    return s;
  }

  void submitAvatar() {
    var _fluttermojiController;
    Get.put(FluttermojiController());
    _fluttermojiController = Get.find<FluttermojiController>();
    _fluttermojiController.setFluttermoji();
    var selectedIndexes = _fluttermojiController.selectedIndexes;
    FluttermojiFunctions().encodeMySVGtoMap().then((avatarMap) {
      setState(() {
        avatar = Avatar.fromJson(avatarMap);
        saved = true;
      });
      // AvatarCubit()..updateAvatar(avatar);
    });
  }
}
