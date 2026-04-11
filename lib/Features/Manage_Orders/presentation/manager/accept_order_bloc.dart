import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Features/Manage_Orders/data/repositories/accept_order_repository.dart';
import 'package:ager_waffer/Features/Manage_Orders/presentation/manager/accept_order_state.dart';
import 'package:bloc/bloc.dart';

class AcceptOrderBloc extends Bloc<AppEvent, AcceptOrderState> {

  AcceptOrderBloc()
      : super(AcceptOrderState(
    status: acceptOrderStatus.initial,
  )) {

    on<AcceptOrderEvent>(_onAcceptOrder);
  }

  Future<void> _onAcceptOrder(
      AcceptOrderEvent event,
      Emitter<AcceptOrderState> emit,
      ) async {

    emit(state.copyWith(status: acceptOrderStatus.loading));

    try {
      final response = await acceptOrderRepository.acceptOrder(
        orderId: event.orderId,
      );
      print("Response success: ${response.isSuccess}");
      print("Message: ${response.messageAr}");
      if (response.isSuccess == true) {
        emit(state.copyWith(status: acceptOrderStatus.success,));
      }

      else {
        emit(state.copyWith(
          status: acceptOrderStatus.failure,
          failureMessage: response.messageAr ?? "فشل في قبول الطلب",
        ));
      }

    } catch (e) {
      emit(state.copyWith(
        status: acceptOrderStatus.failure,
        failureMessage: "فشل في قبول الطلب",
      ));
    }
  }
}