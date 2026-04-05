import 'package:ager_waffer/Features/Home/data/models/item_reviews_model.dart';
import 'package:equatable/equatable.dart';

enum itemReviewStatus { initial, loading, success, failure }
class ItemReviewState extends Equatable {
  final List<Data> reviews;
  final itemReviewStatus status;
  final String failureMessage;

  const ItemReviewState({
    required this.reviews,
    required this.status,
    this.failureMessage = '',
  });

  @override
  List<Object?> get props => [reviews, status, failureMessage];

  ItemReviewState copyWith({
    List<Data>? reviews,
    itemReviewStatus? status,
    String? failureMessage,
  }) {
    return ItemReviewState(
      reviews: reviews ?? this.reviews,
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }
}