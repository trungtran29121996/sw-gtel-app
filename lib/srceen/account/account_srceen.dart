import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_app_gtel/common/config/show_dialog.dart';
import 'package:sw_app_gtel/common/pref/sp_util.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/common/style/textstyles.dart';
import 'package:sw_app_gtel/common/widget/default_button.dart';
import 'package:sw_app_gtel/navigation/route.dart';
import 'package:sw_app_gtel/network/responses/login_response.dart';
import 'package:sw_app_gtel/srceen/account/bloc/account_bloc.dart';
import 'package:sw_app_gtel/srceen/account/bloc/account_event.dart';
import 'package:sw_app_gtel/srceen/account/bloc/account_state.dart';

class AccounutSrceen extends StatefulWidget {
  const AccounutSrceen({super.key});

  @override
  State<AccounutSrceen> createState() => _AccounutSrceenState();
}

class _AccounutSrceenState extends State<AccounutSrceen> {
  AccountBloc accountBloc = AccountBloc();
  MemberInfoLogin user =
      MemberInfoLogin.fromJson(SpUtil.getObject("member_info"));
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => accountBloc,
      child: BlocConsumer<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state.isLogout) {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.INITIAL_ROOT, (router) => false);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFFb3e0ff),
              title: Text('Tài khoản', style: TextStyle(color: Colors.black)),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Stack(
                  children: [
                    // Image.asset(
                    //   IconUtils.headerLogin,
                    //   width: double.infinity,
                    //   fit: BoxFit.fitWidth,
                    // ),
                    SafeArea(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: ColorsUtils.boderGray,
                              child: Image.asset("assets/images/profile.png"),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Driver",
                            style: TextStylesUtils.style12Gray,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Text(
                        user.name!,
                        style: TextStylesUtils.style24BlackBold,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < 4; i++)
                            const Icon(Icons.star,
                                color: Colors.amber, size: 16),
                          const Icon(Icons.star_border,
                              color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          const Text(
                            '4.75',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildItem("Total Trip", "0"),
                          buildItem("Year", "0"),
                          buildItem("Price", "0"),
                        ],
                      ),
                      Divider(
                        color: ColorsUtils.boderGray,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      itemInfo("Só điện thoại", user.phone!),
                      itemInfo("Email", user.email!),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: ColorsUtils.boderGray,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DefaultButton(
                        text: "Logout",
                        textStyle: TextStylesUtils.style16WhiteBold,
                        borderRadius: BorderRadius.circular(15.0),
                        press: () {
                          showAppDialog(
                            context: context,
                            // title: AppLocale.locale(context).logout,
                            // message: AppLocale.locale(context).do_you_want_logout,
                            // successText: AppLocale.locale(context).logout,
                            title: "Đăng xuất",
                            message: "Bạn có muốn đăng xuất",
                            successText: "Đăng xuất",
                            onSucessButtonPressed: () {
                              accountBloc.add(LogoutEvent());
                            },
                          );
                        },
                        // suffixIcon: SizedBox(
                        //   width: 10,
                        // ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildItem(String title, String description) {
    return Column(
      children: [
        Text(
          title,
          style: TextStylesUtils.styleRegular14BrownGreyW400,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          description,
          style: TextStylesUtils.style24BlackBold,
        )
      ],
    );
  }

  Widget itemInfo(String title, String description) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStylesUtils.style16Blod,
          ),
          Text(
            description,
            style: TextStylesUtils.style16Gray,
          )
        ],
      ),
    );
  }
}
