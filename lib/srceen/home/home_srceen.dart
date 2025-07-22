import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sw_app_gtel/common/config/app_dimensions.dart';
import 'package:sw_app_gtel/common/helper/screen_type.dart';
import 'package:sw_app_gtel/common/pref/sp_util.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';
import 'package:sw_app_gtel/network/responses/login_response.dart';
import 'package:sw_app_gtel/srceen/account/account_srceen.dart';
import 'package:sw_app_gtel/srceen/hand_over/hand_over_srceen.dart';
import 'package:sw_app_gtel/srceen/home/widget/main_menu_button.dart';
import 'package:sw_app_gtel/srceen/list_allroute/allroute_screen.dart';
import 'package:sw_app_gtel/srceen/report/report_screen.dart';

class HomeSrceen extends StatefulWidget {
  const HomeSrceen({super.key});

  @override
  State<HomeSrceen> createState() => _HomeSrceenState();
}

class _HomeSrceenState extends State<HomeSrceen> {
  MemberInfoLogin user =
      MemberInfoLogin.fromJson(SpUtil.getObject("member_info"));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(children: [
          SvgPicture.asset(
            "assets/icon/bg_color_home.svg",
            width: getDeviceWidth(context),
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 15,
            left: 16,
            child: SafeArea(
              child:
                  Container(child: Image.asset("assets/images/icon_home.png")),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 24, vertical: Platform.isIOS ? 60 : 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon người dùng
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 2),
                  child: Image.asset('assets/images/icon_user_home.png'),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Xin chào,',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      Text(
                        user.name!,
                        style: TextStylesUtils.style14FnormalBold,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                    child: Image.asset(
                  'assets/images/logo_bghome.png',
                  width: 115,
                ))
                // SvgPicture.asset(
                //   "assets/icon/icon_route_home.svg",
                // ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: Platform.isIOS
                    ? getDeviceHeight(context) * 0.27
                    : getDeviceHeight(context) * 0.3,
                right: 16,
                left: 16),
            child: Container(
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 25,
                mainAxisSpacing: 20,
                childAspectRatio: 1.2,
                children: [
                  BuildMainMenuButton(
                    iconPath: 'assets/icon/icon_route_home.svg',
                    title: "Danh sách chuyến",
                    width: 30,
                    heigth: 30,
                    onButtonPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListAllrouteScreen(
                              screen: SCREEN.SCREEN_LIST_ALL,
                            ),
                          ));
                    },
                  ),
                  BuildMainMenuButton(
                    iconPath: 'assets/icon/icon_pickorder_home.svg',
                    title: "Thao tác lấy hàng",
                    width: 35,
                    heigth: 35,
                    onButtonPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListAllrouteScreen(
                              screen: SCREEN.SCREEN_PICKUP_GOODS,
                            ),
                          ));
                    },
                  ),
                  BuildMainMenuButton(
                    iconPath: 'assets/icon/icon_handover_home.svg',
                    title: "Bàn giao nội bộ",
                    width: 35,
                    heigth: 35,
                    onButtonPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HandOverSrceen(),
                          ));
                    },
                  ),
                  BuildMainMenuButton(
                    iconPath: 'assets/icon/icon_drop_home.svg',
                    title: "Thao tác giao hàng",
                    width: 35,
                    heigth: 35,
                    onButtonPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListAllrouteScreen(
                              screen: SCREEN.SCREEN_DELIVERY,
                            ),
                          ));
                    },
                  ),
                  BuildMainMenuButton(
                    iconPath: 'assets/icon/icon_report_home.svg',
                    title: "Báo cáo & thống kê",
                    width: 40,
                    heigth: 40,
                    onButtonPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReportScreen(),
                          ));
                    },
                  ),
                  BuildMainMenuButton(
                    iconPath: 'assets/icon/icon_account_home.svg',
                    title: "Tài khoản",
                    width: 30,
                    heigth: 30,
                    onButtonPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AccounutSrceen(),
                          ));
                    },
                  ),
                ],
              ),
            ),
          )
        ]));
  }
}
