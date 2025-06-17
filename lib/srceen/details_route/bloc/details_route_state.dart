import 'package:sw_app_gtel/common/config/app_loading.dart';
import 'package:sw_app_gtel/common/core/base/state/base_state.dart';
import 'package:sw_app_gtel/common/utils/status_type.dart';
import 'package:sw_app_gtel/network/responses/data_cpn_route_byid_reponse.dart';
import 'package:sw_app_gtel/network/responses/routing_cpn_start_reponse.dart';

class DetailsRouteState extends BaseState {
  Loading loading;
  DataCnpRouteByIdReponse routeByID;
  List<RouteRequestList> routeRequestList;
  StatusType isRouteStart;
  String message;

  DetailsRouteState(
      {required this.loading,
      required this.routeByID,
      required this.routeRequestList,
      required this.isRouteStart,
      required this.message});
  factory DetailsRouteState.initial() {
    return DetailsRouteState(
        loading: Loading.initial(),
        routeByID: DataCnpRouteByIdReponse(),
        routeRequestList: [],
        isRouteStart: StatusType.DEFAULT,
        message: "");
  }
  DetailsRouteState copyWith(
      {Loading? loading,
      DataCnpRouteByIdReponse? routeByID,
      List<RouteRequestList>? routeRequestList,
      StatusType? isRouteStart,
      UpdatRouteCPNReponse? routingCpnStartReponse,
      String? message}) {
    return DetailsRouteState(
        loading: loading ?? this.loading,
        routeByID: routeByID ?? this.routeByID,
        routeRequestList: routeRequestList ?? this.routeRequestList,
        isRouteStart: isRouteStart ?? this.isRouteStart,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props =>
      [loading, routeByID, routeRequestList, isRouteStart, message];
}
