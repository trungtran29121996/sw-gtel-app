import 'package:flutter/material.dart';
import 'package:sw_app_gtel/common/style/color.dart';

// ignore: must_be_immutable
class InputTextField extends StatelessWidget {
  InputTextField(
      {Key? key,
      this.label = "",
      this.style,
      this.height,
      this.width,
      this.hintText,
      this.suffix,
      this.suffixIcon,
      this.obscureText,
      this.autofocus,
      this.prefix,
      this.prefixIcon,
      this.controller,
      this.onChanged,
      this.borderRadius,
      this.hintStyle,
      this.filled = false,
      this.fillColor,
      this.validator,
      this.keyboardType,
      this.onFieldSubmitted,
      this.enabled = true,
      this.enabledInput = true,
      this.maxLines,
      this.alignLabelWithHint = true,
      this.contentPadding})
      : super(key: key);
  final String label;
  final TextStyle? style;
  final double? height;
  final double? width;
  final String? hintText;
  final Widget? suffix;
  final Widget? suffixIcon;
  final bool? obscureText;
  final bool? autofocus;
  final Widget? prefixIcon;
  final Widget? prefix;
  final bool filled;
  final Color? fillColor;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  void Function(String)? onChanged;
  final BorderRadius? borderRadius;
  String? Function(String?)? validator;
  TextInputType? keyboardType;
  void Function(String)? onFieldSubmitted;
  bool enabled;
  bool enabledInput;
  final int? maxLines;
  bool alignLabelWithHint;
  EdgeInsetsGeometry? contentPadding;

  // GlobalKey<FormState>? formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: height,
      width: width,
      child: TextFormField(
        style: style,
        obscureText: obscureText ?? false,
        controller: controller,
        autofocus: autofocus ?? false,
        decoration: InputDecoration(
            label: Text(label.toString()),
            border: enabled == true
                ? OutlineInputBorder(
                    borderRadius: borderRadius ?? BorderRadius.circular(4),
                  )
                : OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: borderRadius ?? BorderRadius.circular(4)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: enabled == true
                    ? ColorsUtils.bgWareHouse
                    : ColorsUtils.brownGrey,
                width: 1,
              ),
            ),
            contentPadding: contentPadding,
            hintText: hintText,
            hintStyle: hintStyle,
            suffix: suffix,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            prefix: prefix,
            filled: filled,
            fillColor: fillColor ?? Colors.grey.withOpacity(0.6),
            enabled: enabledInput,
            alignLabelWithHint: alignLabelWithHint),
        keyboardType: keyboardType,
        onChanged: onChanged,
        validator: validator,
        onFieldSubmitted: onFieldSubmitted,
        maxLines: maxLines ?? 1,
      ),
    );
  }
}
