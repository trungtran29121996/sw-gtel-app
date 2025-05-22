import 'package:sw_app_gtel/common/core/base/event/base_event.dart';

class BaseLoginEvent extends BaseEvent {}

class LoginEvent extends BaseLoginEvent {
  String phone;
  String passWord;
  LoginEvent({required this.phone, required this.passWord});
}

class CleanControllerEvent extends BaseLoginEvent {
  String editTextController;
  CleanControllerEvent({required this.editTextController});
}
