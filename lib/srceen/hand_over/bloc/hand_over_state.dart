import 'package:sw_app_gtel/common/config/app_loading.dart';
import 'package:sw_app_gtel/common/core/base/state/base_state.dart';
import 'package:sw_app_gtel/network/responses/data_hand_over_reponse.dart';
import 'package:sw_app_gtel/network/responses/image_upload_reponse.dart';
import 'package:sw_app_gtel/network/responses/route_handover_reponse.dart';
import 'package:sw_app_gtel/network/responses/sub_account_reponse.dart';

class HandOverState extends BaseState {
  Loading loading;
  bool handOver;
  List<HandOverReponse> listHandOver;
  SubAccountReponse subAccountReponse;
  ImageUploadReponse imageUploadReponse;
  RouteHandoverReponse routeHandoverReponse;

  HandOverState(
      {required this.loading,
      required this.handOver,
      required this.listHandOver,
      required this.subAccountReponse,
      required this.imageUploadReponse,
      required this.routeHandoverReponse});
  factory HandOverState.initial() {
    return HandOverState(
        loading: Loading.initial(),
        listHandOver: [],
        subAccountReponse: SubAccountReponse(),
        imageUploadReponse: ImageUploadReponse(),
        routeHandoverReponse: RouteHandoverReponse(),
        handOver: false);
  }
  HandOverState copyWith({
    Loading? loading,
    bool? handOver,
    List<HandOverReponse>? listHandOver,
    ImageUploadReponse? imageUploadReponse,
    RouteHandoverReponse? routeHandoverReponse,
    SubAccountReponse? subAccountReponse,
  }) {
    return HandOverState(
        loading: loading ?? this.loading,
        handOver: handOver ?? this.handOver,
        listHandOver: listHandOver ?? this.listHandOver,
        imageUploadReponse: imageUploadReponse ?? this.imageUploadReponse,
        subAccountReponse: subAccountReponse ?? this.subAccountReponse,
        routeHandoverReponse:
            routeHandoverReponse ?? this.routeHandoverReponse);
  }

  @override
  List<Object?> get props => [
        loading,
        handOver,
        listHandOver,
        subAccountReponse,
        imageUploadReponse,
        routeHandoverReponse
      ];
}
