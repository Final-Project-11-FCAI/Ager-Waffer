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

    emit(state.copyWith(status: myOrdersStatus.loading));

    try {
      var response = await myOrdersRepository.getMyOrders();

      if (response.isSuccess == true) {
        emit(state.copyWith(
          status: myOrdersStatus.success,
          orders: response.data!.data ?? [],
        ));
      } else {
        emit(state.copyWith(
          status: myOrdersStatus.failure,
          failureMessage: response.messageAr ?? "Error",
        ));
      }

    } catch (e) {
      print("ERROR: $e");

      emit(state.copyWith(
        status: myOrdersStatus.failure,
        failureMessage: e.toString(),
      ));
    }
  }}

MyOrdersBloc myOrdersBloc = MyOrdersBloc();