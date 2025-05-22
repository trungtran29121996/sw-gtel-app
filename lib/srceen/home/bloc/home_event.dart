import 'package:sw_app_gtel/common/core/base/event/base_event.dart';

class HomeEvent extends BaseEvent {}

class GetAllRoute extends HomeEvent {
  int page;
  int size;
  int driver_id;
  GetAllRoute(
      {required this.page, required this.size, required this.driver_id});
}
