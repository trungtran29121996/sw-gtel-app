import 'package:sw_app_gtel/common/core/base/event/base_event.dart';

class DetailsRouteEvent extends BaseEvent {}

class GetRouteByIDEvent extends DetailsRouteEvent {
  int routeId;
  GetRouteByIDEvent({required this.routeId});
}

class GetRoutingStartEvent extends DetailsRouteEvent {
  int routeId;
  GetRoutingStartEvent({required this.routeId});
}

class GetRoutingCompleteEvent extends DetailsRouteEvent {
  int routeId;
  GetRoutingCompleteEvent({required this.routeId});
}

class InitalEvent extends DetailsRouteEvent {}

class UpdateStatusEvent extends DetailsRouteEvent {
  int driverID;
  int seqID;
  int status;
  String note;
  UpdateStatusEvent(
      {required this.seqID,
      required this.status,
      required this.driverID,
      required this.note});
}

class TrackingLogEvent extends DetailsRouteEvent {
  int requestId;
  TrackingLogEvent({required this.requestId});
}
