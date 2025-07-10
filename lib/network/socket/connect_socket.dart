import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:sw_app_gtel/common/pref/sp_util.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/network/responses/login_response.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  NotificationService._internal();

  void connectSocket(GlobalKey<NavigatorState> navigatorKey) {
    MemberInfoLogin user =
        MemberInfoLogin.fromJson(SpUtil.getObject("member_info"));

    late IO.Socket socket;

    socket = IO.io('https://coreservicestg.smartway24.com', {
      'transports': ['websocket'],
      'path': '/api/v1/tms-service/socket.io',
      'autoConnect': false,
      'auth': {'uid': user.uid}
    });

    socket.onConnect((_) => print('Connected to socket'));

    socket.on('notification', (data) {
      final context = navigatorKey.currentContext;
      if (context != null) {
        showCustomSnack(context, "🔔 Bạn có thông báo mới!");
      }
    });

    socket.connect();
  }

  void showCustomSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: ColorsUtils.textNoti)),
        backgroundColor: ColorsUtils.bgSnackBarNoti,
        duration: Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        margin: EdgeInsets.all(3),
      ),
    );
  }
}
