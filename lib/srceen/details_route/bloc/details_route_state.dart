import 'package:sw_app_gtel/common/config/app_loading.dart';
import 'package:sw_app_gtel/common/core/base/state/base_state.dart';
import 'package:sw_app_gtel/common/utils/status_type.dart';
import 'package:sw_app_gtel/network/responses/data_cpn_route_byid.dart';
import 'package:sw_app_gtel/network/responses/routing_cpn_start.dart';

class DetailsRouteState extends BaseState {
  Loading loading;
  DataCnpRouteByIdReponse routeByID;
  List<RouteRequestList> routeRequestList;
  StatusType isRouteStart;

  DetailsRouteState(
      {required this.loading,
      required this.routeByID,
      required this.routeRequestList,
      required this.isRouteStart});
  factory DetailsRouteState.initial() {
    return DetailsRouteState(
        loading: Loading.initial(),
        routeByID: DataCnpRouteByIdReponse(),
        routeRequestList: [],
        isRouteStart: StatusType.DEFAULT);
  }
  DetailsRouteState copyWith(
      {Loading? loading,
      DataCnpRouteByIdReponse? routeByID,
      List<RouteRequestList>? routeRequestList,
      StatusType? isRouteStart,
      UpdatRouteCPNReponse? routingCpnStartReponse}) {
    return DetailsRouteState(
        loading: loading ?? this.loading,
        routeByID: routeByID ?? this.routeByID,
        routeRequestList: routeRequestList ?? this.routeRequestList,
        isRouteStart: isRouteStart ?? this.isRouteStart);
  }

  @override
  List<Object?> get props =>
      [loading, routeByID, routeRequestList, isRouteStart];
}
