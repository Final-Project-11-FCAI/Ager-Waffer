import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Features/Manage_Orders/data/repositories/decline_order_repository.dart';
import 'package:ager_waffer/Features/Manage_Orders/presentation/manager/decline_order_state.dart';
import 'package:bloc/bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class DeclineOrderBloc extends Bloc<AppEvent, DeclineOrderState> {

  DeclineOrderBloc()
      : super(DeclineOrderState(
    status: declineOrderStatus.initial,
  )) {

    on<DeclineOrderEvent>(_onDeclineOrder);
  }

  Future<void> _onDeclineOrder(
      DeclineOrderEvent event,
      Emitter<DeclineOrderState> emit,
      ) async {

    emit(state.copyWith(status: declineOrderStatus.loading));

    try {
      final response = await declineOrderRepository.declineOrder(
        orderId: event.orderId,
      );

      if (response.isSuccess == true) {
        emit(state.copyWith(
          status: declineOrderStatus.success,
        ));
      }

      else {
        emit(state.copyWith(
          status: declineOrderStatus.failure,
          failureMessage: response.messageAr ?? kDeclineOrderFailed.tr(),
        ));
      }

    } catch (e) {
      emit(state.copyWith(
        status: declineOrderStatus.failure,
        failureMessage: kDeclineOrderFailed.tr(),
      ));
    }
  }
}