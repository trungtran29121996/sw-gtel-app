import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_app_gtel/common/core/base/bloc/base_bloc.dart';
import 'package:sw_app_gtel/common/utils/status_type.dart';
import 'package:sw_app_gtel/network/repository/cpn_route_respository.dart';
import 'package:sw_app_gtel/network/request/create_cpnlot_request.dart';
import 'package:sw_app_gtel/network/responses/data_cpn_route_byid_reponse.dart';
import 'package:sw_app_gtel/network/responses/request_cpn_reponse.dart';
import 'package:sw_app_gtel/network/responses/routing_cpn_start_reponse.dart';
import 'package:sw_app_gtel/network/responses/tracking_log_reponse.dart';
import 'package:sw_app_gtel/srceen/details_route/bloc/details_route_event.dart';
import 'package:sw_app_gtel/srceen/details_route/bloc/details_route_state.dart';

class RouteDetailBloc extends BaseBloc<DetailsRouteEvent, DetailsRouteState> {
  RouteDetailBloc() : super(state: DetailsRouteState.initial()) {
    on<GetRouteByIDEvent>(_onGetRouteById);
    on<GetRoutingStartEvent>(_onRoutingStart);
    on<InitalEvent>(_onInitialState);
    on<TrackingLogEvent>(_onTrackingLog);
    on<GetRequsetCPNEvent>(_onGetGetRequsetCPN);
  }

  CPNRouteRepository cpnRouteRepository = CPNRouteRepository();

  Future _onGetRouteById(GetRouteByIDEvent event, Emitter emit) async {
    try {
      List<RouteRequestList> routeRequestList = [];
      emit.call(state.copyWith(
          loading:
              state.loading.copyWith(isLoading: true, isLoadSuccess: false)));
      DataCnpRouteByIdReponse? routeDetail =
          await cpnRouteRepository.getRouteById(event.routeId);
      if (routeDetail != null) {
        routeRequestList.addAll(routeDetail.routeRequestList!);

        for (int route = 0; route < routeRequestList.length; route++) {
          for (int s = 0; s < routeDetail.sequenceList!.length; s++) {
            if (routeRequestList[route].requestId ==
                routeDetail.sequenceList![s].requestId) {
              routeRequestList[route]
                  .requestInfo!
                  .sequenceList
                  .add(routeDetail.sequenceList![s]);
            }
          }
        }
      }

      emit.call(state.copyWith(
          loading:
              state.loading.copyWith(isLoading: false, isLoadSuccess: true),
          routeByID: routeDetail,
          routeRequestList: routeRequestList));
    } catch (e) {
      print("LOI$e");
      emit.call(state.copyWith(
        loading: state.loading
            .copyWith(isLoading: false, isLoadSuccess: false, loadError: true),
      ));
    }
  }

  //Bắt đầu chuyến
  Future _onRoutingStart(GetRoutingStartEvent event, Emitter emit) async {
    try {
      DataUpdatRouteCPNReponse? routingCpnStartReponse =
          await cpnRouteRepository.getRoutingCPNStart(event.routeId);

      if (routingCpnStartReponse!.success == true) {
        emit.call(state.copyWith(isRouteStart: StatusType.COMPLETED));
      } else {
        emit.call(state.copyWith(
            isRouteStart: StatusType.FAILED,
            message: routingCpnStartReponse.message));
      }
      add(InitalEvent());
    } catch (e) {
      throw Exception(e);
    }
  }

  //Chuyến lô
  Future onCreateCPNLot(
      int requestId, CreateCpnLotRequest createCpnLotRequest) async {
    bool result =
        await cpnRouteRepository.createCPNLot(requestId, createCpnLotRequest);
    return result;
  }

  Future<UpdatRouteCPNReponse?> onRoutingComplete(int route,
      String handover_note, String assignee_id, List<String> lstimage) async {
    UpdatRouteCPNReponse? routingCpnStartReponse = await cpnRouteRepository
        .getRoutingCPNcomplete(route, handover_note, assignee_id, lstimage);
    return routingCpnStartReponse;
  }

  Future<bool> onUpdatetStatus(
      int seqID, int status, int driverID, String note) async {
    bool result =
        await cpnRouteRepository.updateStatusSeq(seqID, status, driverID, note);
    return result;
  }

  Future _onInitialState(InitalEvent event, Emitter emit) async {
    emit.call(state.copyWith(isRouteStart: StatusType.DEFAULT));
  }

  Future _onTrackingLog(TrackingLogEvent event, Emitter emit) async {
    try {
      List<Datum> listTrackingLogReponse = [];
      emit.call(state.copyWith(
          loading:
              state.loading.copyWith(isLoading: true, isLoadSuccess: false)));

      TrackingLogReponse? trackingLogReponse =
          await cpnRouteRepository.trackingLog(event.requestId);
      if (trackingLogReponse!.success == true) {
        listTrackingLogReponse.addAll(trackingLogReponse.data!);
        emit.call(state.copyWith(
            loading:
                state.loading.copyWith(isLoading: false, isLoadSuccess: true),
            listTrackingLogReponse: listTrackingLogReponse,
            trackingLogReponse: trackingLogReponse));
      } else {
        emit.call(state.copyWith(
          loading: state.loading.copyWith(
              isLoading: false, isLoadSuccess: false, loadError: true),
        ));
      }
    } catch (e) {
      emit.call(state.copyWith(
        loading: state.loading
            .copyWith(isLoading: false, isLoadSuccess: false, loadError: true),
      ));
    }
  }

  Future<int> getPackageItemsDoc(RequsetCPN item) async {
    int packageItemsDoc = 0;
    if (item.requestPackageItems.length > 0) {
      for (var element in item.requestPackageItems) {
        if (element.name == "Tài liệu") {
          packageItemsDoc = element.quantity!;
        }
      }
    }
    return packageItemsDoc;
  }

  Future<int> getPackageItemsParcel(RequsetCPN item) async {
    int packageItemsParcel = 0;
    if (item.requestPackageItems.length > 0) {
      for (var element in item.requestPackageItems) {
        if (element.name == "Bưu kiện") {
          packageItemsParcel = element.quantity!;
        }
      }
    }
    return packageItemsParcel;
  }

  Future<int> getSeqStpoppoint(List<SequenceList>? sequenceList) async {
    int seqID = 0;
    for (var element in sequenceList!) {
      if (element.stoppointType == 2 && element.status == 100) {
        seqID = element.seqId!;
        break;
      } else if (element.stoppointType == 3 && element.status == 100) {
        seqID = element.seqId!;
        break;
      } else if (element.stoppointType == 3 && element.status == 101) {
        seqID = element.seqId!;
        break;
      }
    }
    return seqID;
  }

  Future _onGetGetRequsetCPN(GetRequsetCPNEvent event, Emitter emit) async {
    try {
      RequsetCPN? requsetCPN =
          await cpnRouteRepository.getRequsetCPN(event.requestID);

      if (requsetCPN != null) {
        emit.call(state.copyWith(
            loading:
                state.loading.copyWith(isLoading: false, isLoadSuccess: true),
            requsetCPN: requsetCPN));
      }
    } catch (e) {
      print("LOI$e");
      emit.call(state.copyWith(
        loading: state.loading
            .copyWith(isLoading: false, isLoadSuccess: false, loadError: true),
      ));
    }
  }

  //Kết thúc chuyến
  // Future _onRoutingComplete(GetRoutingCompleteEvent event, Emitter emit) async {
  //   try {
  //     CPNRouteRepository cpnRouteRepository = CPNRouteRepository();
  //     emit.call(state.copyWith(
  //         loading:
  //             state.loading.copyWith(isLoading: true, isLoadSuccess: false)));

  //     UpdatRouteCPNReponse? routingCpnStartReponse =
  //         await cpnRouteRepository.getRoutingCPNcomplete(event.routeId);
  //     if (routingCpnStartReponse != null) {
  //       emit.call(state.copyWith(isRouteStart: StatusType.COMPLETED));
  //     } else {
  //       emit.call(state.copyWith(isRouteStart: StatusType.FAILED));
  //     }
  //     add(InitalEvent());
  //   } catch (e) {
  //     emit.call(state.copyWith(
  //         loading: state.loading.copyWith(
  //             isLoading: false, isLoadSuccess: false, loadError: true)));
  //   }
  // }

  //Thay đổi trạng thái lấy hhàng
  // Future _onUpdatetStatus(UpdateStatusEvent event, Emitter emit) async {
  //   try {
  //     CPNRouteRepository cpnRouteRepository = CPNRouteRepository();
  //     emit.call(state.copyWith(
  //         loading:
  //             state.loading.copyWith(isLoading: true, isLoadSuccess: false)));
  //     bool result = await cpnRouteRepository.updateStatusSeq(
  //         event.seqID, event.status, event.driverID, event.note);
  //     if (result) {
  //       emit.call(state.copyWith(
  //           loading:
  //               state.loading.copyWith(isLoading: false, isLoadSuccess: true)));
  //     } else {
  //       emit.call(state.copyWith(
  //           loading: state.loading.copyWith(
  //               isLoading: false, isLoadSuccess: false, loadError: true)));
  //     }
  //   } catch (e) {
  //     emit.call(state.copyWith(
  //         loading: state.loading.copyWith(
  //             isLoading: false, isLoadSuccess: false, loadError: true)));
  //   }
  // }
}
