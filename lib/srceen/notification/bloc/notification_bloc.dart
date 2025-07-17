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

      NotificationReponse? notificationReponse = await notificationRepository
          .getDataNotification(event.size, event.page);
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

  Future<NotificationReponse?> onReadAllNotification(int page, int size) async {
    NotificationReponse? readAllNotification =
        await notificationRepository.readAllNotification(size, page);
    return readAllNotification;
  }

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
