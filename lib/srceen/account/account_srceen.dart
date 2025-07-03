import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_app_gtel/common/config/show_dialog.dart';
import 'package:sw_app_gtel/common/pref/sp_util.dart';
import 'package:sw_app_gtel/navigation/route.dart';
import 'package:sw_app_gtel/network/responses/login_response.dart';
import 'package:sw_app_gtel/srceen/account/bloc/account_bloc.dart';
import 'package:sw_app_gtel/srceen/account/bloc/account_event.dart';
import 'package:sw_app_gtel/srceen/account/bloc/account_state.dart';
import 'package:sw_app_gtel/srceen/account/widget/change_password_srceen.dart';
import 'package:sw_app_gtel/srceen/account/widget/info_account_srceen.dart';

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
              //backgroundColor: Color(0xFFb3e0ff),
              title: Text('Tài khoản', style: TextStyle(color: Colors.black)),
              centerTitle: true,
            ),
            body: Container(
              color: Color(0xFF84D1FF),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 60,
                    child: Image.asset("assets/images/icon_avatar.png"),
                  ),
                  SizedBox(height: 16),
                  Text(
                    user.name!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'ID:${user.memberId}',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  Text(
                    user.phone!,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  SizedBox(height: 24),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFFE5F5FE),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildProfileOption(
                          context,
                          icon: Icons.info_outline,
                          label: 'Thông tin cá nhân',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WidgetInfoAccount(
                                    user: user,
                                  ),
                                ));
                          },
                        ),
                        Divider(),
                        _buildProfileOption(
                          context,
                          icon: Icons.lock_outline,
                          label: 'Đổi mật khẩu',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangePasswordSrceen(
                                    user: user,
                                  ),
                                ));
                          },
                        ),
                        Divider(),
                        _buildProfileOption(
                          context,
                          icon: Icons.logout,
                          label: 'Đăng xuất',
                          onTap: () {
                            showAppDialog(
                              context: context,
                              title: "Đăng xuất",
                              message: "Bạn có muốn đăng xuất",
                              successText: "Đăng xuất",
                              onSucessButtonPressed: () {
                                accountBloc.add(LogoutEvent());
                              },
                            );
                          },
                          isDestructive: true,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      'GtelPost - Application v1.0',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileOption(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap,
      bool isDestructive = false}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: isDestructive ? Colors.red[400] : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: isDestructive ? Colors.white : Colors.black54),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: isDestructive ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: isDestructive ? Colors.white : Colors.black45,
            ),
          ],
        ),
      ),
    );
  }

  // Widget buildItem(String title, String description) {
  //   return Column(
  //     children: [
  //       Text(
  //         title,
  //         style: TextStylesUtils.styleRegular14BrownGreyW400,
  //       ),
  //       SizedBox(
  //         height: 15,
  //       ),
  //       Text(
  //         description,
  //         style: TextStylesUtils.style24BlackBold,
  //       )
  //     ],
  //   );
  // }

  // Widget itemInfo(String title, String description) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(vertical: 10),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(
  //           title,
  //           style: TextStylesUtils.style16Blod,
  //         ),
  //         Text(
  //           description,
  //           style: TextStylesUtils.style16Gray,
  //         )
  //       ],
  //     ),
  //   );
  // }
}
