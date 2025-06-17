import 'package:sw_app_gtel/common/config/app_loading.dart';
import 'package:sw_app_gtel/common/core/base/state/base_state.dart';
import 'package:sw_app_gtel/network/responses/data_cpn_route_reponse.dart';

class HomeState extends BaseState {
  Loading loading;
  List<DataCnpRouteReponse> listRoute;
  int totalStatus;

  HomeState(
      {required this.loading,
      required this.listRoute,
      required this.totalStatus});
  factory HomeState.initial() {
    return HomeState(loading: Loading.initial(), listRoute: [], totalStatus: 0);
  }
  HomeState copyWith({
    Loading? loading,
    List<DataCnpRouteReponse>? listRoute,
    int? totalStatus,
  }) {
    return HomeState(
        loading: loading ?? this.loading,
        listRoute: listRoute ?? this.listRoute,
        totalStatus: totalStatus ?? this.totalStatus);
  }

  @override
  List<Object?> get props => [loading, listRoute, totalStatus];
}
