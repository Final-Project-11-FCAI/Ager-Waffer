import 'package:equatable/equatable.dart';

enum toggleAvailabilityStatus { initial, loading, success, failure }

class ToggleAvailabilityState extends Equatable {
  bool isAvailable;
  toggleAvailabilityStatus status;
  String failureMessage;

  ToggleAvailabilityState({
    required this.isAvailable,
    required this.status,
    this.failureMessage = '',
  });

  @override
  List<Object?> get props => [isAvailable, status, failureMessage];

  ToggleAvailabilityState copyWith({
    bool? isAvailable,
    toggleAvailabilityStatus? status,
    String? failureMessage,
  }) {
    return ToggleAvailabilityState(
      isAvailable: isAvailable ?? this.isAvailable,
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }
}