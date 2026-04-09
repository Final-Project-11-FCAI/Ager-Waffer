import 'package:equatable/equatable.dart';
import '../../data/models/my_orders_model.dart';

enum myOrdersStatus { initial, loading, success, failure }

class MyOrdersState extends Equatable {
  final List<OrderData> orders;
  final myOrdersStatus status;
  final String failureMessage;

  const MyOrdersState({
    required this.orders,
    required this.status,
    this.failureMessage = '',
  });

  @override
  List<Object?> get props => [orders, status, failureMessage];

  MyOrdersState copyWith({
    List<OrderData>? orders,
    myOrdersStatus? status,
    String? failureMessage,
  }) {
    return MyOrdersState(
      orders: orders ?? this.orders,
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }
}