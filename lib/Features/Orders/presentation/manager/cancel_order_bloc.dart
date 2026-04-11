import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Features/Orders/data/repositories/cancel_order_repository.dart';
import 'package:ager_waffer/Features/Orders/presentation/manager/cancel_order_state.dart';
import 'package:bloc/bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class CancelOrderBloc extends Bloc<AppEvent, CancelOrderState> {

  CancelOrderBloc()
      : super(CancelOrderState(
    status: cancelOrderStatus.initial,
  )) {

    on<CancelOrderEvent>(_onCancelOrder);
  }

  Future<void> _onCancelOrder(
      CancelOrderEvent event,
      Emitter<CancelOrderState> emit,
      ) async {

    emit(state.copyWith(status: cancelOrderStatus.loading));

    try {
      final response = await cancelOrderRepository.cancelOrder(
        orderId: event.orderId,
      );

      if (response.isSuccess == true) {
        emit(state.copyWith(
          status: cancelOrderStatus.success,
        ));
      }

      else {
        emit(state.copyWith(
          status: cancelOrderStatus.failure,
          failureMessage: response.messageAr ?? kCancelOrderFailed.tr(),
        ));
      }

    } catch (e) {
      emit(state.copyWith(
        status: cancelOrderStatus.failure,
        failureMessage: kCancelOrderFailed.tr(),
      ));
    }
  }
}