class SendRequestEntity {
  final int itemId;
  final String fromDate;
  final String toDate;
  final bool agreeToTerms;

  SendRequestEntity({
    required this.itemId,
    required this.fromDate,
    required this.toDate,
    required this.agreeToTerms,
  });
}