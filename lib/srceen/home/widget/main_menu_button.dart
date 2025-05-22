import 'package:flutter/material.dart';
import 'package:sw_app_gtel/common/config/app_dimensions.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';

class BuildMainMenuButton extends StatelessWidget {
  final String path;
  final String text;
  final Function onButtonPressed;

  const BuildMainMenuButton({
    super.key,
    required this.text,
    required this.onButtonPressed,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => onButtonPressed(),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(AppDimensions.borderCircularSmall),
        ),
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingSmall),
                child: Container(
                  child: Image.asset(
                    path,
                    width: 45,
                  ),
                )),
            const SizedBox(
              height: AppDimensions.paddingSmall,
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingSmall),
              child: Text(text,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStylesUtils.style15Fw400),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(AppDimensions.paddingSmall),
            //   child: Text(textV1 ?? "",
            //       maxLines: 2,
            //       textAlign: TextAlign.center,
            //       style: TextStylesUtils.style14Fnormal),
            // ),
          ],
        ),
      ),
    );
  }
}
