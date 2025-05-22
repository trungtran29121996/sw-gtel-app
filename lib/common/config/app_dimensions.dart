import 'package:flutter/cupertino.dart';

/// Device screen height
double getDeviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

/// Device screen width
double getDeviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

class AppDimensions {
  //--- UI Start ---
  static const double designSizeWidth = 360;
  static const double designSizeHeight = 690;

  static const double mapSizeHeight = 250;

  // Icon
  static const double iconSizeXSmall = 5;
  static const double iconSizeSmall = 10;
  static const double iconSizeMedium = 15;
  static const double iconSizeLarge = 20;
  static const double iconSizeXLarge = 25;
  static const double iconSizeXXLarge = 30;
  static const double iconSize3XLarge = 40;
  static const double iconSize4XLarge = 50;
  static const double iconSize5XLarge = 65;

  // Padding
  static const double paddingXSmall = 3;
  static const double paddingSmall = 5;
  static const double paddingXMedium = 8;
  static const double paddingMedium = 10;
  static const double paddingLarge = 15;
  static const double paddingXLarge = 20;
  static const double paddingXXLarge = 25;
  static const double padding3XLarge = 30;
  static const double padding4XLarge = 35;
  static const double padding5XLarge = 40;
  static const double padding6XLarge = 45;
  static const double padding7XLarge = 50;
  static const double padding8XLarge = 90;
  static const double padding9XLarge = 100;
  static const double padding10XLarge = 200;

  // Button
  static const double buttonHeightMedium = 40;
  static const double buttonHeightLarge = 50;
  static const double buttonHeightLargest = 55;

  // Border
  static const double borderWidthMedium = 3;
  static const double borderWidthLarge = 5;
  static const double borderCircularSmall = 10;
  static const double borderCircularMedium = 15;
  static const double borderCircularLarge = 20;
  static const double borderCircularXLarge = 30;
  static const double borderCircularXXXXLarge = 60;

  /// Font
  static const double fontSizeSmall = 13;
  static const double fontSizeXNormal = 15;
  static const double fontSizeLarge = 16;
  static const double fontSizeSubHeading = 18;

  // Image Settings
  static const double imageMaxWidth = 1920;
  static const double imageMaxHeight = 1350;
  static const double smallImgWidth = 150;
  static const double smallImgHeight = 150;
  static const int imageQuality = 100;

  // Indicator Settings
  static const double indicatorSizeLarge = 30;
  static const double indicatorStrokeWidthLarge = 3;
}
