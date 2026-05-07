import 'package:equatable/equatable.dart';

import '../../data/models/add_report_model.dart';

enum addReportStatus { initial, loading, success, failure, }

class AddReportState extends Equatable {

  final Data reportData;
  final addReportStatus status;
  final String failureMessage;

  const AddReportState({
    required this.reportData,
    required this.status,
    this.failureMessage = '',
  });

  @override
  List<Object?> get props => [reportData, status, failureMessage,];

  AddReportState copyWith({
    Data? reportData,
    addReportStatus? status,
    String? failureMessage,
  }) {
    return AddReportState(
      reportData: reportData ?? this.reportData,
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }
}