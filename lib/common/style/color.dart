import 'package:flutter/material.dart';

class ColorsUtils {
  static const MaterialColor primaryMaterialColor =
      MaterialColor(0xff00B5E2, <int, Color>{
    50: Color(0xff00B5E2), //10%
    100: Color(0xff00B5E2), //20%
    200: Color(0xff00B5E2), //30%
    300: Color(0xff00B5E2), //40%
    400: Color(0xff00B5E2), //50%
    500: Color(0xff00B5E2), //60%
    600: Color(0xff00B5E2), //70%
    700: Color(0xff00B5E2), //80%
    800: Color(0xff00B5E2), //90%
    900: Color(0xff00B5E2), //1
  });

  static final driverTheme = ThemeData(
    primarySwatch: primaryMaterialColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: ColorsUtils.bgWareHouse,
      secondary: ColorsUtils.bgWareHouse,
    ),
  );

  static const bgWareHouse = Color(0xff00B5E2);
  static const bgHomeMenu = Color(0xffE5F5FE);
  static const bgHome = Color(0xff84D1FF);
  static const primaryText = Color(0xFF202020);
  static const textNamegreyItem = Color(0xFF7C7C7C);
  static const disableButon = Color(0xFFe0e0e0);
  static const textColorGrey = Color(0xff717171);
  static const normalText = Color(0xff000000);
  static const boderGray = Color(0xFFF4F4F4);
  static const brownGrey = Color(0xff848484);
  static const infoItemContact = Color(0xffFFAE61);
  static const statusContact = Color(0xffDEDCF5);
  static const iconReason = Color(0xff818181);
  static const itemCodeOrder = Color(0xff4E99C7);
  static const statusNotification = Color(0xFF56AB57);
  static const fillInput = Color(0xFFF1F1F1);
  static const handover = Color(0xFF5DC3FC);
  static const btnHandover = Color(0xFFFF6F61);
  static const columChart = Color(0xFF00B5E2);
  static const bgSnackBarNoti = Color(0xFFDCF5FC);
  static const textNoti = Color(0xFF4E99C7);
  static const bgPinned = Color.fromARGB(255, 247, 252, 255);
}
