import 'package:equatable/equatable.dart';

enum acceptOrderStatus { initial, loading, success, failure }

class AcceptOrderState extends Equatable {

  acceptOrderStatus status;
  String failureMessage;

  AcceptOrderState({
    required this.status,
    this.failureMessage = '',
  });

  @override
  List<Object?> get props => [status, failureMessage];

  AcceptOrderState copyWith({
    acceptOrderStatus? status,
    String? failureMessage,
  }) {
    return AcceptOrderState(
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }
}