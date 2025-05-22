import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sw_app_gtel/common/config/app_dimensions.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';

class NoBillScreen extends StatelessWidget {
  final String? title;

  NoBillScreen({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Hiện tại",
              style: TextStylesUtils.styleRegular24TEXTGREY,
            ),
            const SizedBox(
              height: AppDimensions.paddingSmall,
            ),
            Text(title ?? "Không có dữ liệu",
                style: TextStylesUtils.styleBold18(
                    Theme.of(context).primaryColor)),
            SizedBox(
              height: 7,
            ),
            SizedBox(
              height: 150.h,
              child: Image.asset("assets/images/bg_no_bill.webp"),
            ),
          ],
        ),
      ),
    );
  }
}
