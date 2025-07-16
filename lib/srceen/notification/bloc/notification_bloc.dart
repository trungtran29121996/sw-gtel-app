import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_app_gtel/common/core/base/bloc/base_bloc.dart';
import 'package:sw_app_gtel/common/utils/status_type.dart';
import 'package:sw_app_gtel/network/repository/notification_repository.dart';
import 'package:sw_app_gtel/network/responses/data_notification_reponse.dart';
import 'package:sw_app_gtel/network/responses/read_notification_reponse.dart';
import 'package:sw_app_gtel/srceen/notification/bloc/notification_event.dart';
import 'package:sw_app_gtel/srceen/notification/bloc/notification_state.dart';

class NotificationBloc extends BaseBloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(state: NotificationState.initial()) {
    on<GetNotificationEvent>(_onGetNotification);
    on<InitalNotificationEvent>(_onInitialState);
  }
  NotificationRepository notificationRepository = NotificationRepository();

  Future _onGetNotification(GetNotificationEvent event, Emitter emit) async {
    try {
      List<Datum> dataNotifition = [];
      List<Datum> dataListUnRead = [];
      emit.call(state.copyWith(
          loading:
              state.loading.copyWith(isLoading: true, isLoadSuccess: false)));

      NotificationReponse? notificationReponse =
          await notificationRepository.getDataNotification();
      if (notificationReponse!.success == true) {
        dataNotifition.addAll(notificationReponse.data!);

        for (var e in dataNotifition) {
          if (e.readAt == "") {
            dataListUnRead.add(e);
          }
        }

        emit.call(state.copyWith(
          loading:
              state.loading.copyWith(isLoading: false, isLoadSuccess: true),
          notificationReponse: notificationReponse,
          datum: dataNotifition,
          lstNotiUnRead: dataListUnRead,
        ));
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

  // Future _onReadNotification(ReadNotificationEvent event, Emitter emit) async {
  //   try {
  //     ReadNotificationReponse? routingCpnStartReponse =
  //         await notificationRepository.readNotification(event.notification_id);

  //     if (routingCpnStartReponse!.success == true) {
  //       emit.call(state.copyWith(isNotification: StatusType.COMPLETED));
  //     } else {
  //       emit.call(state.copyWith(isNotification: StatusType.FAILED));
  //     }
  //     add(InitalNotificationEvent());
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  Future<ReadNotificationReponse?> onReadNotification(
      int notification_id) async {
    ReadNotificationReponse? readNotificationReponse =
        await notificationRepository.readNotification(notification_id);
    return readNotificationReponse;
  }

  Future _onInitialState(InitalNotificationEvent event, Emitter emit) async {
    emit.call(state.copyWith(isNotification: StatusType.DEFAULT));
  }
}
