import 'package:sw_app_gtel/common/core/base/event/base_event.dart';

class ListAklRouteEvent extends BaseEvent {}

class GetAllRoute extends ListAklRouteEvent {
  int page;
  int size;
  int driver_id;
  List<int> request_type;
  GetAllRoute(
      {required this.page,
      required this.size,
      required this.driver_id,
      required this.request_type});
}
