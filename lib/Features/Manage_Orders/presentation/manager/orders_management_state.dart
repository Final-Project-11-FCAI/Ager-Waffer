import 'package:ager_waffer/Features/Manage_Orders/data/models/orders_management_model.dart';
import 'package:equatable/equatable.dart';

enum ordersManagementStatus { initial, loading, success, failure }

class OrdersManagementState extends Equatable {
  final List<OrderManagementData> ordersManagement;
  final ordersManagementStatus status;
  final String failureMessage;

  const OrdersManagementState({
    required this.ordersManagement,
    required this.status,
    this.failureMessage = '',
  });

  @override
  List<Object?> get props => [ordersManagement, status, failureMessage];

  OrdersManagementState copyWith({
    List<OrderManagementData>? ordersManagement,
    ordersManagementStatus? status,
    String? failureMessage,
  }) {
    return OrdersManagementState(
      ordersManagement: ordersManagement ?? this.ordersManagement,
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }
}