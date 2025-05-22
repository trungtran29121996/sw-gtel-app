import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_app_gtel/common/pref/sp_util.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/srceen/account/account_srceen.dart';
import 'package:sw_app_gtel/srceen/home/bloc/home_bloc.dart';
import 'package:sw_app_gtel/srceen/home/bloc/home_event.dart';
import 'package:sw_app_gtel/srceen/home/bloc/home_state.dart';
import 'package:sw_app_gtel/srceen/home/home_srceen.dart';
import 'package:sw_app_gtel/srceen/list_allroute/list_allroute_screen.dart';
import 'package:sw_app_gtel/srceen/notification/notification_screen.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  HomeBloc homeBloc = HomeBloc();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => homeBloc
          ..add(GetAllRoute(
              page: 1, size: 20, driver_id: SpUtil.getInt("driverId"))),
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          final List<Widget> _screen = [
            const HomeSrceen(),
            ListAllrouteScreen(
              lstDataCnpRoute: state.listRoute,
            ),
            const NoficationScreen(),
            const AccounutSrceen(),
          ];
          return Scaffold(
            body: _screen[_currentIndex],
            bottomNavigationBar: Container(
              height: 70,
              child: BottomNavigationBar(
                  selectedFontSize: 10.0,
                  unselectedFontSize: 10.0,
                  selectedItemColor: ColorsUtils.primaryMaterialColor,
                  unselectedItemColor: Colors.black,
                  showUnselectedLabels: true,
                  currentIndex: _currentIndex,
                  onTap: (value) {
                    setState(() {
                      _currentIndex = value;
                    });
                  },
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        size: 25,
                      ),
                      label: "Trang chủ",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.edit_document,
                        size: 25,
                      ),
                      label: "Vận đơn",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.notifications_none_rounded,
                        size: 25,
                      ),
                      label: "Thông báo",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.settings_outlined,
                        size: 25,
                      ),
                      label: "Tài khoản",
                    ),
                  ]),
            ),
          );
        }));
  }
}
