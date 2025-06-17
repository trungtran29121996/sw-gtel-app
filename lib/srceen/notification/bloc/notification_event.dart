import 'package:sw_app_gtel/common/core/base/event/base_event.dart';

class NotificationEvent extends BaseEvent {}

class GetNotificationEvent extends NotificationEvent {
  GetNotificationEvent();
}

class ReadNotificationEvent extends NotificationEvent {
  int notification_id;
  ReadNotificationEvent({required this.notification_id});
}

class InitalNotificationEvent extends NotificationEvent {}
