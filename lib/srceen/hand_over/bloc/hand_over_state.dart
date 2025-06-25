import 'package:sw_app_gtel/common/config/app_loading.dart';
import 'package:sw_app_gtel/common/core/base/state/base_state.dart';
import 'package:sw_app_gtel/network/responses/data_hand_over_reponse.dart';
import 'package:sw_app_gtel/network/responses/image_upload_reponse.dart';
import 'package:sw_app_gtel/network/responses/sub_account_reponse.dart';

class HandOverState extends BaseState {
  Loading loading;
  bool handOver;
  List<HandOverReponse> listHandOver;
  SubAccountReponse subAccountReponse;
  ImageUploadReponse imageUploadReponse;

  HandOverState(
      {required this.loading,
      required this.handOver,
      required this.listHandOver,
      required this.subAccountReponse,
      required this.imageUploadReponse});
  factory HandOverState.initial() {
    return HandOverState(
        loading: Loading.initial(),
        listHandOver: [],
        subAccountReponse: SubAccountReponse(),
        imageUploadReponse: ImageUploadReponse(),
        handOver: false);
  }
  HandOverState copyWith(
      {Loading? loading,
      bool? handOver,
      List<HandOverReponse>? listHandOver,
      ImageUploadReponse? imageUploadReponse,
      SubAccountReponse? subAccountReponse}) {
    return HandOverState(
        loading: loading ?? this.loading,
        handOver: handOver ?? this.handOver,
        listHandOver: listHandOver ?? this.listHandOver,
        imageUploadReponse: imageUploadReponse ?? this.imageUploadReponse,
        subAccountReponse: subAccountReponse ?? this.subAccountReponse);
  }

  @override
  List<Object?> get props =>
      [loading, handOver, listHandOver, subAccountReponse, imageUploadReponse];
}
