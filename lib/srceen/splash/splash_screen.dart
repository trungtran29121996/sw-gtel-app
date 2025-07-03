import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_app_gtel/navigation/route.dart';
import 'package:sw_app_gtel/network/socket/connect_socket.dart';
import 'package:sw_app_gtel/srceen/splash/bloc/splash_bloc.dart';
import 'package:sw_app_gtel/srceen/splash/bloc/splash_event.dart';
import 'package:sw_app_gtel/srceen/splash/bloc/splash_state.dart';

class SplashScreen extends StatefulWidget {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  SplashScreen({required this.navigatorKey});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(SplashEvent()),
      child: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {
          //NotificationService().showNotification();
          NotificationService().connectSocket(widget.navigatorKey);
          if (state.isExDate) {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.NAVIGATION_BAR, (route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.LOGIN, (route) => false);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Center(
                    child: Image.asset(
                      "assets/icon/icon_logo.webp",
                      width: 100,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
