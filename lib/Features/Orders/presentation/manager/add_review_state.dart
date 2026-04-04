import 'package:equatable/equatable.dart';
import '../../data/models/add_review_model.dart';

enum addReviewStatus { initial, loading, success, failure }

class AddReviewState extends Equatable {
  final Data? reviewData;
  final addReviewStatus status;
  final String failureMessage;

  const AddReviewState({
    this.reviewData,
    this.status = addReviewStatus.initial,
    this.failureMessage = '',
  });

  @override
  List<Object?> get props => [reviewData, status, failureMessage];

  AddReviewState copyWith({
    Data? reviewData,
    addReviewStatus? status,
    String? failureMessage,
  }) {
    return AddReviewState(
      reviewData: reviewData ?? this.reviewData,
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }
}