import 'package:sw_app_gtel/common/config/app_loading.dart';
import 'package:sw_app_gtel/common/core/base/state/base_state.dart';
import 'package:sw_app_gtel/common/utils/status_type.dart';
import 'package:sw_app_gtel/network/responses/data_cpn_route_byid_reponse.dart';
import 'package:sw_app_gtel/network/responses/request_cpn_reponse.dart';
import 'package:sw_app_gtel/network/responses/routing_cpn_start_reponse.dart';
import 'package:sw_app_gtel/network/responses/tracking_log_reponse.dart';

class DetailsRouteState extends BaseState {
  Loading loading;
  DataCnpRouteByIdReponse routeByID;
  List<RouteRequestList> routeRequestList;
  StatusType isRouteStart;
  String message;
  TrackingLogReponse trackingLogReponse;
  List<Datum> listTrackingLogReponse;
  RequsetCPN requsetCPN;
  List<bool> isExpansion;
  List<RouteRequestList> routeRequestListComplete;
  List<RouteRequestList> routeRequestListCurrent;

  DetailsRouteState(
      {required this.loading,
      required this.routeByID,
      required this.routeRequestList,
      required this.isRouteStart,
      required this.message,
      required this.trackingLogReponse,
      required this.listTrackingLogReponse,
      required this.requsetCPN,
      required this.isExpansion,
      required this.routeRequestListComplete,
      required this.routeRequestListCurrent});
  factory DetailsRouteState.initial() {
    return DetailsRouteState(
        loading: Loading.initial(),
        routeByID: DataCnpRouteByIdReponse(),
        routeRequestList: [],
        isRouteStart: StatusType.DEFAULT,
        message: "",
        trackingLogReponse: TrackingLogReponse(),
        listTrackingLogReponse: [],
        requsetCPN: RequsetCPN(requestPackageItems: [], urlPictures: []),
        isExpansion: [],
        routeRequestListComplete: [],
        routeRequestListCurrent: []);
  }
  DetailsRouteState copyWith(
      {Loading? loading,
      DataCnpRouteByIdReponse? routeByID,
      List<RouteRequestList>? routeRequestList,
      StatusType? isRouteStart,
      UpdatRouteCPNReponse? routingCpnStartReponse,
      String? message,
      TrackingLogReponse? trackingLogReponse,
      List<Datum>? listTrackingLogReponse,
      RequsetCPN? requsetCPN,
      List<bool>? isExpansion,
      List<RouteRequestList>? routeRequestListComplete,
      List<RouteRequestList>? routeRequestListCurrent}) {
    return DetailsRouteState(
        loading: loading ?? this.loading,
        routeByID: routeByID ?? this.routeByID,
        routeRequestList: routeRequestList ?? this.routeRequestList,
        isRouteStart: isRouteStart ?? this.isRouteStart,
        message: message ?? this.message,
        trackingLogReponse: trackingLogReponse ?? this.trackingLogReponse,
        listTrackingLogReponse:
            listTrackingLogReponse ?? this.listTrackingLogReponse,
        requsetCPN: requsetCPN ?? this.requsetCPN,
        isExpansion: isExpansion ?? this.isExpansion,
        routeRequestListCurrent:
            routeRequestListCurrent ?? this.routeRequestListCurrent,
        routeRequestListComplete:
            routeRequestListComplete ?? this.routeRequestListComplete);
  }

  @override
  List<Object?> get props => [
        loading,
        routeByID,
        routeRequestList,
        isRouteStart,
        message,
        trackingLogReponse,
        listTrackingLogReponse,
        requsetCPN,
        isExpansion,
        routeRequestListComplete,
        routeRequestListCurrent
      ];
}
