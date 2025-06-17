import 'package:sw_app_gtel/common/config/app_loading.dart';
import 'package:sw_app_gtel/common/core/base/state/base_state.dart';
import 'package:sw_app_gtel/common/utils/status_type.dart';
import 'package:sw_app_gtel/network/responses/data_notification_reponse.dart';

class NotificationState extends BaseState {
  Loading loading;
  NotificationReponse notificationReponse;
  List<Datum> datum;
  StatusType isNotification;

  NotificationState(
      {required this.loading,
      required this.notificationReponse,
      required this.datum,
      required this.isNotification});
  factory NotificationState.initial() {
    return NotificationState(
        loading: Loading.initial(),
        notificationReponse: NotificationReponse(),
        datum: [],
        isNotification: StatusType.DEFAULT);
  }
  NotificationState copyWith(
      {Loading? loading,
      NotificationReponse? notificationReponse,
      List<Datum>? datum,
      StatusType? isNotification}) {
    return NotificationState(
      loading: loading ?? this.loading,
      notificationReponse: notificationReponse ?? this.notificationReponse,
      datum: datum ?? this.datum,
      isNotification: isNotification ?? this.isNotification,
    );
  }

  @override
  List<Object?> get props =>
      [loading, notificationReponse, isNotification, datum];
}
