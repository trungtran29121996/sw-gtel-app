import 'package:sw_app_gtel/network/api/dio_main.dart';
import 'package:sw_app_gtel/network/responses/data_notification_reponse.dart';
import 'package:sw_app_gtel/network/responses/read_notification_reponse.dart';

class NotificationRepository {
  DioMain dioMain = DioMain();
  Future<NotificationReponse?> getDataNotification() async {
    try {
      final response = await dioMain.get("notification-system/user");
      return NotificationReponse.fromJson(response);
    } catch (e) {
      print("${e.toString()}");
    }
    return null;
  }

  Future<ReadNotificationReponse?> readNotification(int notification_id) async {
    try {
      final response = await dioMain
          .patch("notification-system/notification/${notification_id}");
      return ReadNotificationReponse.fromJson(response);
    } catch (e) {
      print("${e.toString()}");
    }
    return null;
  }
}
