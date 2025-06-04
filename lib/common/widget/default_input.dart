import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';

class DefaultInput extends StatelessWidget {
  DefaultInput(
      {super.key,
      this.label,
      this.autofocus = false,
      this.labelStyle,
      this.obscureText = false,
      this.borderRadius,
      this.colorBorderSide,
      this.prefixIcon,
      this.prefix,
      this.suffixIcon,
      this.suffix,
      this.textEditingController,
      this.readOnly = false,
      this.keyboardType,
      this.onChanged,
      this.validator,
      this.focusNode,
      this.enabled = true,
      this.hintText,
      this.hintStyle,
      this.style,
      this.textAlign = TextAlign.start,
      this.maxLength,
      this.isRequire = false,
      this.filled,
      this.fillColor,
      this.border,
      this.enabledBorder,
      this.disabledBorder,
      this.labelRequire,
      this.maxLines = 1,
      this.inputFormatters,
      this.contentPadding});
  final Widget? label;
  final TextStyle? labelStyle;
  final bool autofocus;
  final bool obscureText;
  final double? borderRadius;
  final Color? colorBorderSide;
  final Widget? prefixIcon;
  final Widget? prefix;
  final Widget? suffixIcon;
  final Widget? suffix;
  final TextEditingController? textEditingController;
  final bool readOnly;
  final TextInputType? keyboardType;
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  final FocusNode? focusNode;
  final bool enabled;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final TextAlign textAlign;
  final int? maxLength;
  final bool isRequire;
  final bool? filled;
  final Color? fillColor;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final String? labelRequire;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: textEditingController,
      autofocus: autofocus,
      readOnly: readOnly,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      inputFormatters: inputFormatters ?? [],
      focusNode: focusNode,
      style: style,
      textAlign: textAlign,
      maxLength: maxLength,
      maxLines: maxLines,
      decoration: InputDecoration(
          label: isRequire
              ? RichText(
                  text: TextSpan(children: [
                  TextSpan(
                      text: labelRequire,
                      style: TextStylesUtils.styleRegular14BrownGreyW400),
                  TextSpan(text: "*", style: TextStyle(color: Colors.red))
                ]))
              : label,
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          labelStyle: labelStyle ?? TextStylesUtils.styleRegular14BrownGreyW400,
          hintText: hintText,
          hintStyle: hintStyle ?? TextStylesUtils.styleRegular14BrownGreyW400,
          prefixIcon: prefixIcon,
          prefix: prefix,
          suffixIcon: suffixIcon,
          suffix: suffix,
          enabled: enabled,
          filled: filled,
          fillColor: fillColor,
          border: border ??
              UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: colorBorderSide ?? ColorsUtils.brownGrey)),
          enabledBorder: enabledBorder ??
              UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: colorBorderSide ?? ColorsUtils.brownGrey)),
          disabledBorder: disabledBorder ??
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 5),
                  borderSide: BorderSide(
                      color: colorBorderSide ?? ColorsUtils.brownGrey))),
    );
  }
}
