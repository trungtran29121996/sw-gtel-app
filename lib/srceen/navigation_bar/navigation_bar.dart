import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/srceen/account/account_srceen.dart';
import 'package:sw_app_gtel/srceen/home/home_srceen.dart';
import 'package:sw_app_gtel/srceen/notification/bloc/notification_bloc.dart';
import 'package:sw_app_gtel/srceen/notification/bloc/notification_state.dart';
import 'package:sw_app_gtel/srceen/notification/notification_screen.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  NotificationBloc notificationBloc = NotificationBloc();
  int _currentIndex = 0;

  final List<Widget> _screen = [
    HomeSrceen(),
    NoficationScreen(),
    AccounutSrceen(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => notificationBloc,
        child: BlocConsumer<NotificationBloc, NotificationState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                body: _screen[_currentIndex],
                bottomNavigationBar: Container(
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
                          icon: Stack(
                            children: [
                              Icon(Icons.notifications_none_rounded),
                              // Positioned(
                              //   right: 0,
                              //   top: 0,
                              //   bottom: 10,
                              //   child: Container(
                              //     padding: EdgeInsets.all(0),
                              //     decoration: BoxDecoration(
                              //       color: Colors.red,
                              //       borderRadius: BorderRadius.circular(10),
                              //     ),
                              //     constraints: BoxConstraints(
                              //       minWidth: 15,
                              //       minHeight: 15,
                              //     ),
                              //     child: Text(
                              //       "${state.lstNotiUnRead.length}",
                              //       style: TextStyle(
                              //         color: Colors.white,
                              //         fontSize: 10,
                              //       ),
                              //       textAlign: TextAlign.center,
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                          label: 'Thông báo',
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
