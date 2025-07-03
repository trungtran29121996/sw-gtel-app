import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sw_app_gtel/srceen/hand_over/hand_over_srceen.dart';
import 'package:sw_app_gtel/srceen/home/home_srceen.dart';
import 'package:sw_app_gtel/srceen/login/login_srceen.dart';
import 'package:sw_app_gtel/srceen/navigation_bar/navigation_bar.dart';
import 'package:sw_app_gtel/srceen/splash/splash_screen.dart';

class AppRoutes {
  static const String INITIAL_ROOT = "/";
  static const String LOGIN = "/login";
  static const String HOME = "/home";
  static const String NAVIGATION_BAR = "/navigation_bar";
  static const String LIST_ROUTE = "/list_route";
  static const String HAND_OVER = "/hand_over";
  static Route<dynamic> generateRoute(RouteSettings settings) {
    GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    Widget screen;
    switch (settings.name) {
      case INITIAL_ROOT:
        screen = SplashScreen(
          navigatorKey: navigatorKey,
        );
        break;
      case LOGIN:
        screen = LoginScreen();
        break;
      case HOME:
        screen = HomeSrceen();
        break;
      case NAVIGATION_BAR:
        screen = BottomNavigationPage();
        break;
      case HAND_OVER:
        screen = HandOverSrceen();
        break;

      default:
        screen = Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        );
    }

    return CupertinoPageRoute(builder: (_) => screen);
  }
}
