import 'dart:io';

class AddReportEntity {
  final String description;
  final String type;
  final File attachment;
  final String reportedUserId;

  AddReportEntity({
    required this.description,
    required this.type,
    required this.attachment,
    required this.reportedUserId,
  });
}