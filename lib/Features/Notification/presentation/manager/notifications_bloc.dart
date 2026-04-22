import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Features/Notification/data/repositories/notifications_repository.dart';
import 'package:ager_waffer/Features/Notification/presentation/manager/notifications_state.dart';
import 'package:bloc/bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class NotificationsBloc extends Bloc<AppEvent, NotificationsState> {

  NotificationsBloc()
      : super(NotificationsState(
    notifications: [],
    status: notificationsStatus.initial,
  )) {

    on<GetNotificationsEvent>(_onGetNotifications);
  }

  Future<void> _onGetNotifications(
      GetNotificationsEvent event,
      Emitter<NotificationsState> emit,
      ) async {

    emit(state.copyWith(status: notificationsStatus.loading));

    try {
      var response = await notificationsRepository.getNotifications();

      if (response.isSuccess == true) {
        print("notifications count: ${response.data?.data?.length}");

        emit(state.copyWith(
          status: notificationsStatus.success,
          notifications: response.data?.data ?? [],
        ));
      } else {
        emit(state.copyWith(
          status: notificationsStatus.failure,
          failureMessage: response.messageAr ?? kSomethingWrong.tr(),
        ));
      }

    } catch (e) {
      print("ERROR: $e");

      emit(state.copyWith(
        status: notificationsStatus.failure,
        failureMessage: kServerError.tr(),
      ));
    }
  }
}

NotificationsBloc notificationsBloc = NotificationsBloc();