import 'package:flutter/material.dart';
import 'package:sw_app_gtel/common/style/color.dart';

class TextStylesUtils {
  //18
  static styleBold18(Color color) => TextStyle(
        fontFamily: "Roboto",
        color: color,
        fontWeight: FontWeight.w600,
        fontSize: 18,
        fontStyle: FontStyle.normal,
      );

//24
  static final styleRegular24TEXTGREY = TextStyle(
    fontFamily: "Roboto",
    color: ColorsUtils.textColorGrey,
    fontWeight: FontWeight.w500,
    fontSize: 24,
    fontStyle: FontStyle.normal,
  );

//15
  static const style15Fw400 = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );

//16
  static const style16Blod = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );

//20
  static const styleBoldAppBar = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 20,
    fontStyle: FontStyle.normal,
  );

//14 red
  static const style14FnormalRed = TextStyle(
    color: Colors.red,
    fontSize: 14,
    fontStyle: FontStyle.normal,
  );

  static const style14FnormalGrey = TextStyle(
    color: ColorsUtils.textColorGrey,
    fontSize: 14,
    fontStyle: FontStyle.normal,
  );

  static const style14Fnormalwhite = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontStyle: FontStyle.normal,
  );

//16 blue
  static const style16FnormalBlue = TextStyle(
    color: ColorsUtils.bgHome,
    fontSize: 16,
    fontStyle: FontStyle.normal,
  );

  static const style16ItemCodeOrder = TextStyle(
    color: ColorsUtils.itemCodeOrder,
    fontSize: 16,
    fontStyle: FontStyle.normal,
  );

//black
  static const style16Fnormalblack = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontStyle: FontStyle.normal,
  );

  static const style16Orange = TextStyle(
    color: ColorsUtils.infoItemContact,
    fontSize: 16,
    fontStyle: FontStyle.normal,
  );

  static const style14FnormalBlack = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontStyle: FontStyle.normal,
  );

//30
  static final styleLight30Black = TextStyle(
    fontFamily: "RobotoLight",
    color: ColorsUtils.normalText,
    fontSize: 30,
    fontStyle: FontStyle.normal,
  );

  static textStatus(Color Color) =>
      TextStyle(color: Color, fontSize: 14, fontWeight: FontWeight.w500);

  static textProfile(Color Color) =>
      TextStyle(color: Color, fontSize: 16, fontWeight: FontWeight.w500);

  static text14w600(Color color) =>
      TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w600);
  static final textTabarHistory =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  static final text14w600Black =
      TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600);
  static final text16w600Black =
      TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600);
}
