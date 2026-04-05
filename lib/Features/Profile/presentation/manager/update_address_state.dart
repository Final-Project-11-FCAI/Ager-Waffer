import 'package:equatable/equatable.dart';
import '../../data/models/update_address_model.dart';

enum updateAddressStatus { initial, loading, success, failure }

class UpdateAddressState extends Equatable {
  Data addressData;
  updateAddressStatus status;
  String failureMessage;

  UpdateAddressState({
    required this.addressData,
    required this.status,
    this.failureMessage = '',
  });

  @override
  List<Object?> get props => [addressData, status, failureMessage];

  UpdateAddressState copyWith({
    Data? addressData,
    updateAddressStatus? status,
    String? failureMessage,
  }) {
    return UpdateAddressState(
      addressData: addressData ?? this.addressData,
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }
}