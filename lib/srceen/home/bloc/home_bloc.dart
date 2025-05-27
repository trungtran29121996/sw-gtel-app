import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_app_gtel/common/core/base/bloc/base_bloc.dart';
import 'package:sw_app_gtel/network/repository/cpn_route_respository.dart';
import 'package:sw_app_gtel/network/responses/data_cpn_route.dart';
import 'package:sw_app_gtel/srceen/home/bloc/home_event.dart';
import 'package:sw_app_gtel/srceen/home/bloc/home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc() : super(state: HomeState.initial()) {
    on<GetAllRoute>(_onGetAllRoute);
  }
  Future _onGetAllRoute(GetAllRoute event, Emitter emit) async {
    try {
      List<DataCnpRouteReponse> lstFilter = [];
      if (event.page == 1) {
        emit.call(state.copyWith(
            loading:
                state.loading.copyWith(isLoading: true, isLoadSuccess: false)));
      } else {
        emit.call(
            state.copyWith(loading: state.loading.copyWith(isLoading: false)));
      }
      int statusNew = 0;
      int statusPickup = 0;
      int statusDelivery = 0;
      int totalStatus = 0;
      CPNRouteRepository routeRepository = CPNRouteRepository();
      List<DataCnpRouteReponse> listAllRoute = await routeRepository
          .getAllRoute(event.page, event.size, event.driver_id);

      if (listAllRoute.isNotEmpty) {
        for (var element in listAllRoute) {
          if (element.status == 100) {
            statusNew++;
          } else if (element.status == 310) {
            statusPickup++;
          } else if (element.status == 320) {
            statusDelivery++;
          }

          if (element.status == 100 ||
              element.status == 310 ||
              element.status == 320) {
            lstFilter.add(element);
          }
        }
      }
      totalStatus = statusNew + statusPickup + statusDelivery;

      emit.call(state.copyWith(
          loading:
              state.loading.copyWith(isLoading: false, isLoadSuccess: true),
          listRoute: lstFilter,
          totalStatus: totalStatus));
    } catch (e) {
      print("LOI$e");
      emit.call(state.copyWith(
          loading: state.loading.copyWith(
              isLoading: false, isLoadSuccess: false, loadError: true),
          listRoute: []));
    }
  }
}
