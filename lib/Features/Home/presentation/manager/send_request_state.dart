import 'package:equatable/equatable.dart';
import 'package:ager_waffer/Features/Home/data/models/send_request_model.dart';


enum sendRequestStatus { initial, loading, success, failure }

class SendRequestState extends Equatable {
  final Data? rentalData;
  final sendRequestStatus status;
  final String failureMessage;

  const SendRequestState({
    this.rentalData,
    this.status = sendRequestStatus.initial,
    this.failureMessage = '',
  });

  @override
  List<Object?> get props => [rentalData, status, failureMessage];

  SendRequestState copyWith({
    Data? rentalData,
    sendRequestStatus? status,
    String? failureMessage,
  }) {
    return SendRequestState(
      rentalData: rentalData ?? this.rentalData,
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }
}