import 'package:flutter/material.dart';

class SmilingEarthIcon {
  static Image getIcon(double emission) {
    var image = AssetImage('assets/img/smiling-earth/earth1.png');
    if (emission > 100) {
      image = AssetImage('assets/img/smiling-earth/earth5.png');
    } else if (emission > 80) {
      image = AssetImage('assets/img/smiling-earth/earth4.png');
    } else if (emission > 50) {
      image = AssetImage('assets/img/smiling-earth/earth3.png');
    } else if (emission > 10) {
      image = AssetImage('assets/img/smiling-earth/earth2.png');
    } else {
      image = AssetImage('assets/img/smiling-earth/earth1.png');
    }

    return Image(height: 33, width: 33, image: image);
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
