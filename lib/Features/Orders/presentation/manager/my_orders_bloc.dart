import 'dart:io';

import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Features/Orders/data/repositories/my_orders_repository.dart';
import 'package:ager_waffer/Features/Orders/presentation/manager/my_orders_state.dart';
import 'package:bloc/bloc.dart';

class MyOrdersBloc extends Bloc<AppEvent, MyOrdersState> {
  MyOrdersBloc()
      : super(MyOrdersState(
    orders: [],
    status: myOrdersStatus.initial,
  )) {
    on<GetMyOrdersEvent>(_onGetMyOrders);
  }

  Future<void> _onGetMyOrders(
      GetMyOrdersEvent event,
      Emitter<MyOrdersState> emit,
      ) async {
    emit(state.copyWith(
      status: myOrdersStatus.loading,
      failureMessage: null,
    ));

    try {
      final response = await myOrdersRepository.getMyOrders();

      if (response.isSuccess == true && response.data != null) {
        emit(state.copyWith(
          status: myOrdersStatus.success,
          orders: response.data?.data ?? [],
          failureMessage: null,
        ));
      }

      else {
        emit(state.copyWith(
          status: myOrdersStatus.failure,
          failureMessage: response.messageAr ?? "حدث خطأ",
          orders: [],
        ));
      }
    }

    catch (e) {
      print("ERROR: $e");

      String message = "حدث خطأ غير متوقع";

      if (e is SocketException ||
          e.toString().contains("Network is unreachable")) {
        message = "لا يوجد اتصال بالإنترنت";
      }

      emit(state.copyWith(
        status: myOrdersStatus.failure,
        failureMessage: message,
        orders: [], // 🔥 VERY IMPORTANT
      ));
    }
  }
}

MyOrdersBloc myOrdersBloc = MyOrdersBloc();