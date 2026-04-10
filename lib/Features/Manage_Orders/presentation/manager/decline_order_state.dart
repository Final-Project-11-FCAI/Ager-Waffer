import 'package:equatable/equatable.dart';

enum declineOrderStatus { initial, loading, success, failure }

class DeclineOrderState extends Equatable {

  declineOrderStatus status;
  String failureMessage;

  DeclineOrderState({
    required this.status,
    this.failureMessage = '',
  });

  @override
  List<Object?> get props => [status, failureMessage];

  DeclineOrderState copyWith({
    declineOrderStatus? status,
    String? failureMessage,
  }) {
    return DeclineOrderState(
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }
}