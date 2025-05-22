import 'package:flutter/material.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/common/widget/default_button.dart';

Future<T?> showAppDialog<T>({
  required BuildContext context,
  required String title,
  final Widget? suffixIcon,
  String? message,
  final Widget? widgetCancel,
  final Widget? widgetSuccess,
  String? cancelText,
  VoidCallback? onCancelButtonPressed,
  String? successText,
  VoidCallback? onSucessButtonPressed,
  bool barrierDismissible = true,
  bool isHiddenCancel = false,
}) async {
  return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return Container(
          height: double.infinity,
          child: Dialog(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(child: suffixIcon),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      message ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      isHiddenCancel == false
                          ? Expanded(
                              child: DefaultButton(
                              text: cancelText ?? "Huỷ",
                              backgroundColor: Colors.white,
                              textColor: ColorsUtils.primaryMaterialColor,
                              borderColor: ColorsUtils.boderGray,
                              press: () {
                                onCancelButtonPressed;
                                Navigator.pop(context);
                              },
                            ))
                          : SizedBox(),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: DefaultButton(
                        text: successText ?? "OK",
                        backgroundColor: ColorsUtils.bgHome,
                        press: onSucessButtonPressed ??
                            () => Navigator.pop(context),
                      ))
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}
