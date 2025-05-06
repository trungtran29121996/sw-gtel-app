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
      primary: ColorsUtils.bgDriver,
      secondary: ColorsUtils.bgDriver,
    ),
  );

  static const bgDriver = Color(0xff00B5E2);
}
