import 'dart:convert';

import 'package:flutter_svg/svg.dart';
import 'package:fluttermoji/fluttermojiFunctions.dart';

class Avatar {
  static Map<String, dynamic> emoji = {
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
  final int topType;
  final int accessoriesType;
  final int hairColor;
  final int facialHairType;
  final int facialHairColor;
  final int clotheType;
  final int eyeType;
  final int eyebrowType;
  final int mouthType;
  final int skinColor;
  final int clotheColor;
  final int style;
  final int graphicType;
  final Map<String?, dynamic> jsonValue;

  Avatar(
      this.topType,
      this.accessoriesType,
      this.hairColor,
      this.facialHairType,
      this.facialHairColor,
      this.clotheType,
      this.eyeType,
      this.eyebrowType,
      this.mouthType,
      this.skinColor,
      this.clotheColor,
      this.style,
      this.graphicType,
      this.jsonValue);

  factory Avatar.fromJson(Map<String?, dynamic> json) {
    return new Avatar(
        json['topType'],
        json['accessoriesType'],
        json['hairColor'],
        json['facialHairType'],
        json['facialHairColor'],
        json['clotheType'],
        json['eyeType'],
        json['eyebrowType'],
        json['mouthType'],
        json['skinColor'],
        json['clotheColor'],
        json['style'],
        json['graphicType'],
        json);
  }

  factory Avatar.fromLocal(Map<String?, dynamic> json) {
    return new Avatar(
        json['topType'],
        json['accessoriesType'],
        json['hairColor'],
        json['facialHairType'],
        json['facialHairColor'],
        json['clotheType'],
        json['eyeType'],
        json['eyebrowType'],
        json['mouthType'],
        json['skinColor'],
        json['clotheColor'],
        json['style'],
        json['graphicType'],
        Map<String, dynamic>());
  }

// Map<String, String> toJson(){
//   return
// }

  // String toJson(){
  //   return JsonEncoder()
  // }
  static SvgPicture toSvg(Avatar avatar) {
    try {
      String svg = FluttermojiFunctions()
          .decodeFluttermojifromString(jsonEncode(avatar.jsonValue));
      var s = SvgPicture.string(svg);
      return s;
    } catch (e) {
      String svg =
          FluttermojiFunctions().decodeFluttermojifromString(jsonEncode(emoji));
      var s = SvgPicture.string(svg);
      return s;
    }
  }
}
