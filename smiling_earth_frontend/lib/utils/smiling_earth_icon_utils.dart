import 'package:flutter/material.dart';

class SmilingEarthIcon {
  static Image getIcon(int emission) {
    return Image(
        height: 33,
        width: 33,
        image: AssetImage('assets/img/smiling-earth/earth1.png'));
  }

  static Image getLargeIcon() {
    return Image(
        height: 220,
        width: 220,
        image: AssetImage('assets/img/smiling-earth/earth1.png'));
  }

  static Image getSmallIcon(int imageIndex) {
    return Image(
        height: 60,
        width: 60,
        image: AssetImage(
            'assets/img/smiling-earth/earth' + imageIndex.toString() + '.png'));
  }
}
