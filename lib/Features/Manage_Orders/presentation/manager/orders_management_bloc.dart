import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Features/Manage_Orders/data/repositories/orders_management_repository.dart';
import 'package:ager_waffer/Features/Manage_Orders/presentation/manager/orders_management_state.dart';
import 'package:bloc/bloc.dart';

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

    emit(state.copyWith(status: ordersManagementStatus.loading));

    try {
      var response = await ordersManagementRepository.getOrdersManagement();

      if (response.isSuccess == true) {
        emit(state.copyWith(
          status: ordersManagementStatus.success,
          ordersManagement: response.data!.data ?? [],
        ));
      } else {
        emit(state.copyWith(
          status: ordersManagementStatus.failure,
          failureMessage: response.messageAr ?? "Error",
        ));
      }

    } catch (e) {
      print("ERROR: $e");

      emit(state.copyWith(
        status: ordersManagementStatus.failure,
        failureMessage: e.toString(),
      ));
    }
  }}

OrdersManagementBloc ordersManagementBloc = OrdersManagementBloc();