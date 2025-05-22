import 'package:flutter/material.dart';
import 'package:sw_app_gtel/common/style/color.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {Key? key,
      this.text,
      this.press,
      this.backgroundColor,
      this.textColor,
      this.borderColor,
      this.disable,
      this.width,
      this.height,
      this.textSize,
      this.isLoading = false,
      this.textStyle,
      this.child,
      this.borderRadius,
      this.side,
      this.shape,
      this.padding,
      this.margin})
      : super(key: key);
  final String? text;
  final Color? backgroundColor;
  final Color? textColor;
  final Function? press;
  final Color? borderColor;
  final bool? disable;
  final double? width;
  final double? height;
  final double? textSize;
  final bool isLoading;
  final TextStyle? textStyle;
  final Widget? child;
  final BorderRadiusGeometry? borderRadius;
  final BorderSide? side;
  final OutlinedBorder? shape;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 50,
      padding: padding ?? const EdgeInsets.all(0),
      margin: margin ?? EdgeInsets.all(0),
      child: TextButton(
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: shape ??
                RoundedRectangleBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(5),
                  side: side ??
                      BorderSide(
                        color: borderColor ?? Colors.transparent,
                        width: 1.0,
                      ),
                ),
            // primary: backgroundColor != null
            //     // ? AppColors.primaryGreyText
            //     ? Colors.white
            //     : Colors.white,
            backgroundColor: disable == true
                ? ColorsUtils.disableButon
                : backgroundColor ?? ColorsUtils.bgWareHouse),
        onPressed: disable == true
            ? null
            : isLoading
                ? null
                : press as void Function()?,
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2.68,
              )
            : child ??
                Text(
                  text!,
                  style: textStyle ??
                      TextStyle(
                        fontSize: textSize ?? 16,
                        color: textColor ?? Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                ),
      ),
    );
  }
}
