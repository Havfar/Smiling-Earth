import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttermoji/fluttermoji.dart';

class FlutterMojiPage extends StatefulWidget {
  final String title;
  FlutterMojiPage({Key? key, required this.title}) : super(key: key);

  @override
  _FlutterMojiPageState createState() => _FlutterMojiPageState();
}

class _FlutterMojiPageState extends State<FlutterMojiPage> {
  // final Map<String, dynamic> emoji =
  final Map<String, dynamic> emoji = {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Use your Fluttermoji anywhere\nwith the below widget",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          // FluttermojiCircleAvatar(
          //   backgroundColor: Colors.grey[200],
          //   radius: 100,
          // ),
          Container(
            width: 100,
            height: 100,
            child: getEmoji(),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "and create your own page to customize them using our widgets",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Spacer(flex: 2),
              Expanded(
                flex: 3,
                child: Container(
                  height: 35,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.edit),
                    label: Text("Customize"),
                    onPressed: () => Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => NewPage())),
                  ),
                ),
              ),
              Spacer(flex: 2),
            ],
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.edit),
            label: Text("Save"),
            onPressed: () {
              String x = '';
              FluttermojiFunctions().encodeMySVGtoString().then((value) {
                print(value);
                return x = value;
              });
              print('aha');
              print(x);
              print('ahahaha');

              print(FluttermojiFunctions().decodeFluttermojifromString(x));
            },
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  SvgPicture getEmoji() {
    String svg =
        FluttermojiFunctions().decodeFluttermojifromString(jsonEncode(emoji));
    var s = SvgPicture.string(svg);
    return s;
  }
}

class NewPage extends StatelessWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: FluttermojiCircleAvatar(
              radius: 100,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
            child: FluttermojiCustomizer(
              //scaffoldHeight: 400,
              showSaveWidget: true,
            ),
          ),
        ],
      ),
    );
  }
}
