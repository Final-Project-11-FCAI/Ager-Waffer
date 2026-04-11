import 'package:equatable/equatable.dart';

enum deviceRegisterStatus { initial, loading, success, failure }

class DeviceRegisterState extends Equatable {
  final bool? isRegistered;
  final deviceRegisterStatus status;
  final String failureMessage;

  const DeviceRegisterState({
    this.isRegistered,
    this.status = deviceRegisterStatus.initial,
    this.failureMessage = '',
  });

  @override
  List<Object?> get props => [isRegistered, status, failureMessage];

  DeviceRegisterState copyWith({
    bool? isRegistered,
    deviceRegisterStatus? status,
    String? failureMessage,
  }) {
    return DeviceRegisterState(
      isRegistered: isRegistered ?? this.isRegistered,
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }
}