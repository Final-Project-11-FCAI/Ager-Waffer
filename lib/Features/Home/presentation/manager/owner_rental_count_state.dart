import 'package:equatable/equatable.dart';

enum ownerRentalCountStatus { initial, loading, success, failure }

class OwnerRentalCountState extends Equatable {
  final int count;
  final ownerRentalCountStatus status;
  final String failureMessage;

  const OwnerRentalCountState({
    this.count = 0,
    this.status = ownerRentalCountStatus.initial,
    this.failureMessage = '',
  });

  @override
  List<Object?> get props => [count, status, failureMessage];

  OwnerRentalCountState copyWith({
    int? count,
    ownerRentalCountStatus? status,
    String? failureMessage,
  }) {
    return OwnerRentalCountState(
      count: count ?? this.count,
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }
}