import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_app_gtel/common/pref/sp_util.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/srceen/home/bloc/home_bloc.dart';
import 'package:sw_app_gtel/srceen/home/bloc/home_event.dart';
import 'package:sw_app_gtel/srceen/home/bloc/home_state.dart';
import 'package:sw_app_gtel/srceen/home/widget/main_menu_button.dart';
import 'package:sw_app_gtel/srceen/list_allroute/allroute_screen.dart';

class HomeSrceen extends StatefulWidget {
  const HomeSrceen({super.key});

  @override
  State<HomeSrceen> createState() => _HomeSrceenState();
}

class _HomeSrceenState extends State<HomeSrceen> {
  HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => homeBloc
          ..add(GetAllRoute(
              page: 1, size: 20, driver_id: SpUtil.getInt("driverId"))),
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return Scaffold(
              backgroundColor: ColorsUtils.bgHome,
              resizeToAvoidBottomInset: true,
              //appBar: AppBar(),
              body: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 15),
                        child: Image.asset(
                          "assets/images/bg_home.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Container(
                            margin: EdgeInsets.only(top: 130),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: ColorsUtils.bgHomeMenu),
                            child: GridView(
                              padding: EdgeInsets.all(8),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5,
                                      childAspectRatio: 1.1),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                BuildMainMenuButton(
                                  //Status: Mới + Đang lấy hàng + Đang giao hàng
                                  path: "assets/images/list_order_menu.png",
                                  text:
                                      "Danh sách chuyến (${state.totalStatus})",
                                  onButtonPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ListAllrouteScreen(),
                                        ));
                                  },
                                ),
                                BuildMainMenuButton(
                                  path: "assets/images/receive_orders_menu.png",
                                  text: "Tiếp nhận đơn hàng",
                                  onButtonPressed: () {},
                                ),
                                BuildMainMenuButton(
                                  path: "assets/images/order_handover_menu.png",
                                  text: "Bàn giao đơn hàng",
                                  onButtonPressed: () {},
                                ),
                                BuildMainMenuButton(
                                  path: "assets/images/delivery_menu.png",
                                  text: "Giao đơn hàng",
                                  onButtonPressed: () {},
                                ),
                                BuildMainMenuButton(
                                  path: "assets/images/baocao_thongke_menu.png",
                                  text: "Báo cáo & thống kê",
                                  onButtonPressed: () {},
                                ),
                                BuildMainMenuButton(
                                  path: "assets/images/account_menu.png",
                                  text: "Tài khoản",
                                  onButtonPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ));
        }));
  }
}

class IconUtils {}
