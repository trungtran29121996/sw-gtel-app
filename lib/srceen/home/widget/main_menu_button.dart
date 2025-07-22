import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';

class BuildMainMenuButton extends StatelessWidget {
  final String iconPath;
  final String title;
  final double width;
  final double heigth;
  final Function onButtonPressed;

  const BuildMainMenuButton(
      {super.key,
      required this.iconPath,
      required this.onButtonPressed,
      required this.title,
      required this.heigth,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: InkWell(
        onTap: () {
          onButtonPressed();
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: SvgPicture.asset(
                width: width,
                height: heigth,
                iconPath,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(title,
                  textAlign: TextAlign.center,
                  style: TextStylesUtils.style14FnormalBlack),
            ),
          ],
        ),
      ),
    );

    // return GestureDetector(
    //   onTap: () async => onButtonPressed(),
    //   child: Card(
    //     color: Colors.white,
    //     shape: RoundedRectangleBorder(
    //       borderRadius:
    //           BorderRadius.circular(AppDimensions.borderCircularSmall),
    //     ),
    //     elevation: 3,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Padding(
    //             padding: const EdgeInsets.all(AppDimensions.paddingSmall),
    //             child: Container(
    //               child: Image.asset(
    //                 path,
    //                 width: 45,
    //               ),
    //             )),
    //         const SizedBox(
    //           height: AppDimensions.paddingSmall,
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.all(AppDimensions.paddingSmall),
    //           child: Text(text,
    //               maxLines: 2,
    //               textAlign: TextAlign.center,
    //               style: TextStylesUtils.style15Fw400),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
