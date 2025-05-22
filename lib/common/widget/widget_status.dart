import 'package:flutter/material.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';

class WidgetStatus extends StatelessWidget {
  WidgetStatus(
      {super.key,
      required this.status,
      this.color,
      this.textStyle,
      this.backgroundColor});
  Color? color;
  Color? backgroundColor;
  TextStyle? textStyle;
  int status;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(3),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
            color: getStatusInfo(status)["color"],
            borderRadius: BorderRadius.circular(8),
            border:
                Border.all(color: color ?? ColorsUtils.brownGrey, width: 1)),
        child: Text(
          getStatusInfo(status)["text"],
          style: TextStylesUtils.textStatus(getStatusInfo(status)["textColor"]),
        ));
  }

  Map<String, dynamic> getStatusInfo(int status) {
    switch (status) {
      case 100:
        return {
          "textColor": Color(0xFF12A613),
          "text": "Chuyến mới tạo",
          "color": Color(0xFFE6FFE6)
        };
      case 310:
        return {
          "textColor": Color(0xFF4E99C7),
          "text": "Đang lấy hàng",
          "color": Color(0xFFDCF5FC)
        };
      case 320:
        return {
          "textColor": Color(0xFFCC6600),
          "text": "Đã giao hàng",
          "color": Color(0xFFDCF5FC)
        };
      case 500:
        return {
          "textColor": Color(0xFF525252),
          "text": "Hoàn thành",
          "color": Color(0xFFEEEEEE)
        };
      default:
        return {
          "text": "Không xác định",
          "color": Colors.white,
        };
    }
  }
}
