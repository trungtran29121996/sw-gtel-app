import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';

// ignore: must_be_immutable
class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  String? title;
  Widget? action;
  Function? onTap;
  String? icon;
  Color? backgroundColor;
  bool centerTitle;
  double? elevation;
  Widget? leading;

  DefaultAppBar(
      {this.title,
      this.action,
      this.onTap,
      this.icon,
      this.backgroundColor,
      this.leading,
      this.elevation,
      this.centerTitle = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.white,
      title: Text(title ?? "", style: TextStylesUtils.styleBoldAppBar),
      iconTheme: IconThemeData(color: Colors.black),
      elevation: elevation ?? 0,
      shadowColor: Colors.white,
      centerTitle: centerTitle,
      leading: leading,
      actions: <Widget>[action ?? SizedBox()],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55);
}

// ignore: must_be_immutable
class DefaultIconAppBar extends StatelessWidget {
  Color? colorIcon;
  String? icon;
  Function? onTap;

  DefaultIconAppBar({this.icon, this.onTap, this.colorIcon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: SvgPicture.asset(
          icon ?? "",
          color: colorIcon ?? Colors.black,
        ),
        onPressed: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {});
          onTap!();
        });
  }
}
