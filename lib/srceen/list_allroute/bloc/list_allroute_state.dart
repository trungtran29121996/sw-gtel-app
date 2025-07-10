import 'package:sw_app_gtel/common/config/app_loading.dart';
import 'package:sw_app_gtel/common/core/base/state/base_state.dart';
import 'package:sw_app_gtel/network/responses/data_cpn_route_reponse.dart';

class ListAklRouteState extends BaseState {
  Loading loading;
  List<DataCnpRouteReponse> listRoute;
  int totalStatus;

  ListAklRouteState(
      {required this.loading,
      required this.listRoute,
      required this.totalStatus});
  factory ListAklRouteState.initial() {
    return ListAklRouteState(
        loading: Loading.initial(), listRoute: [], totalStatus: 0);
  }
  ListAklRouteState copyWith({
    Loading? loading,
    List<DataCnpRouteReponse>? listRoute,
    int? totalStatus,
  }) {
    return ListAklRouteState(
        loading: loading ?? this.loading,
        listRoute: listRoute ?? this.listRoute,
        totalStatus: totalStatus ?? this.totalStatus);
  }

  @override
  List<Object?> get props => [loading, listRoute, totalStatus];
}
