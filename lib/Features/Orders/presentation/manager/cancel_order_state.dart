import 'package:equatable/equatable.dart';

enum cancelOrderStatus { initial, loading, success, failure }

class CancelOrderState extends Equatable {

  cancelOrderStatus status;
  String failureMessage;

  CancelOrderState({
    required this.status,
    this.failureMessage = '',
  });

  @override
  List<Object?> get props => [status, failureMessage];

  CancelOrderState copyWith({
    cancelOrderStatus? status,
    String? failureMessage,
  }) {
    return CancelOrderState(
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }
}