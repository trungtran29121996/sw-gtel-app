import 'package:sw_app_gtel/common/core/base/event/base_event.dart';

class AccountEvent extends BaseEvent {}

class LogoutEvent extends AccountEvent {}

class ChangePassWordEvent extends AccountEvent {
  String oldPassword;
  String newPassword;
  String renewPassword;
  ChangePassWordEvent(
      {required this.oldPassword,
      required this.newPassword,
      required this.renewPassword});
}
