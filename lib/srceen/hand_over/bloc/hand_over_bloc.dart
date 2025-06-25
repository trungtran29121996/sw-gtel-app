import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_app_gtel/common/core/base/bloc/base_bloc.dart';
import 'package:sw_app_gtel/network/repository/hand_over_repository.dart';
import 'package:sw_app_gtel/network/responses/data_hand_over_reponse.dart';
import 'package:sw_app_gtel/network/responses/image_upload_reponse.dart';
import 'package:sw_app_gtel/network/responses/sub_account_reponse.dart';
import 'package:sw_app_gtel/srceen/hand_over/bloc/hand_over_event.dart';
import 'package:sw_app_gtel/srceen/hand_over/bloc/hand_over_state.dart';

class HandOverBloc extends BaseBloc<HandOverEvent, HandOverState> {
  HandOverBloc() : super(state: HandOverState.initial()) {
    on<GetAllHandOver>(_onGetAllHandOver);
    on<GetSubAccount>(_onGetSubAccount);
    //on<UploadImage>(_onUploadImage);
  }
  HandOverRepository handOverRepository = HandOverRepository();
  Future _onGetAllHandOver(GetAllHandOver event, Emitter emit) async {
    try {
      List<HandOverReponse> listAllHandOver = [];
      List<HandOverReponse> lstHandOver = [];
      emit.call(state.copyWith(
          loading:
              state.loading.copyWith(isLoading: true, isLoadSuccess: false)));

      listAllHandOver = await handOverRepository.getAllHandOver(
          event.page, event.size, event.driver_id);

      if (listAllHandOver.isNotEmpty) {
        for (int i = 0; i < listAllHandOver.length; i++) {
          if (listAllHandOver[i].status == 310 ||
              listAllHandOver[i].status == 320 ||
              listAllHandOver[i].status == 330 ||
              listAllHandOver[i].status == 430) {
            lstHandOver.add(listAllHandOver[i]);
          }
        }
      }
      emit.call(state.copyWith(
          loading: state.loading.copyWith(
            isLoading: false,
            isLoadSuccess: true,
          ),
          listHandOver: lstHandOver,
          handOver: true));
    } catch (e) {
      print("LOI $e");
      emit.call(state.copyWith(
          loading: state.loading.copyWith(
              isLoading: false, isLoadSuccess: false, loadError: true)));
    }
  }

  Future _onGetSubAccount(GetSubAccount event, Emitter emit) async {
    try {
      SubAccountReponse subAccountReponse = SubAccountReponse();
      emit.call(state.copyWith(
          loading:
              state.loading.copyWith(isLoading: true, isLoadSuccess: false)));

      subAccountReponse = await handOverRepository.getSubAccount(
          event.page, event.size, event.service_provider_id);

      emit.call(state.copyWith(
          loading:
              state.loading.copyWith(isLoading: false, isLoadSuccess: true),
          subAccountReponse: subAccountReponse));
    } catch (e) {
      print("LOI $e");
      emit.call(state.copyWith(
          loading: state.loading.copyWith(
              isLoading: false, isLoadSuccess: false, loadError: true)));
    }
  }

  Future<ImageUploadReponse?> onUploadImage(
      int routeId, File imageFile, bool deletable, Directory dir) async {
    ImageUploadReponse uploadReponse = ImageUploadReponse();
    uploadReponse = await handOverRepository.uploadImage(
        routeId, imageFile, deletable, dir);

    return uploadReponse;

    // try {
    //   ImageUploadReponse uploadReponse = ImageUploadReponse();
    //   emit.call(state.copyWith(
    //       loading:
    //           state.loading.copyWith(isLoading: true, isLoadSuccess: false)));
    //   HandOverRepository handOverRepository = HandOverRepository();
    //   uploadReponse =
    //       await handOverRepository.uploadImage(event.routeId, event.imageFile);

    //   emit.call(state.copyWith(
    //       loading:
    //           state.loading.copyWith(isLoading: false, isLoadSuccess: true),
    //       imageUploadReponse: uploadReponse));
    // } catch (e) {
    //   print("LOI $e");
    //   emit.call(state.copyWith(
    //       loading: state.loading.copyWith(
    //           isLoading: false, isLoadSuccess: false, loadError: true)));
    // }
  }

  // Future<UpdatRouteCPNReponse?> onRoutingComplete(int route) async {
  //   // cpnRouteRepository = CPNRouteRepository();
  //   // UpdatRouteCPNReponse? routingCpnStartReponse =
  //   //     await cpnRouteRepository.getRoutingCPNcomplete(route);
  //   // return routingCpnStartReponse;
  // }
}
