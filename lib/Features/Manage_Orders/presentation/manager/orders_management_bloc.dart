import 'dart:io';

import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Features/Manage_Orders/data/repositories/orders_management_repository.dart';
import 'package:ager_waffer/Features/Manage_Orders/presentation/manager/orders_management_state.dart';
import 'package:bloc/bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class OrdersManagementBloc extends Bloc<AppEvent, OrdersManagementState> {
  OrdersManagementBloc()
      : super(OrdersManagementState(
    ordersManagement: [],
    status: ordersManagementStatus.initial,
  )) {
    on<GetOrdersManagementEvent>(_onGetOrdersManagement);
  }

  Future<void> _onGetOrdersManagement(
      GetOrdersManagementEvent event,
      Emitter<OrdersManagementState> emit,
      ) async {
    emit(state.copyWith(
      status: ordersManagementStatus.loading,
      failureMessage: null,
    ));

    try {
      final response =
      await ordersManagementRepository.getOrdersManagement();

      if (response.isSuccess == true && response.data != null) {
        emit(state.copyWith(
          status: ordersManagementStatus.success,
          ordersManagement: response.data?.data ?? [],
          failureMessage: null,
        ));
      }

      else {
        emit(state.copyWith(
          status: ordersManagementStatus.failure,
          failureMessage: response.messageAr ?? kSomethingWrong.tr(),
          ordersManagement: [],
        ));
      }
    }

    catch (e) {
      print("ERROR: $e");

      String message = kUnexpectedError.tr();

      if (e is SocketException ||
          e.toString().contains("Network is unreachable")) {
        message = kNoInternet.tr();
      }

      emit(state.copyWith(
        status: ordersManagementStatus.failure,
        failureMessage: message,
        ordersManagement: [], // 🔥 VERY IMPORTANT
      ));
    }
  }
}

OrdersManagementBloc ordersManagementBloc = OrdersManagementBloc();