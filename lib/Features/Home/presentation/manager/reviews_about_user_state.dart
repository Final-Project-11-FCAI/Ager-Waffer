import 'package:ager_waffer/Features/Home/data/models/reviews_about_user_model.dart';
import 'package:equatable/equatable.dart';

enum reviewsAboutUserStatus { initial, loading, success, failure }

class ReviewsAboutUserState extends Equatable {
  final List<Data> reviews;
  final reviewsAboutUserStatus status;
  final String failureMessage;

  const ReviewsAboutUserState({
    required this.reviews,
    required this.status,
    this.failureMessage = '',
  });

  @override
  List<Object?> get props => [reviews, status, failureMessage];

  ReviewsAboutUserState copyWith({
    List<Data>? reviews,
    reviewsAboutUserStatus? status,
    String? failureMessage,
  }) {
    return ReviewsAboutUserState(
      reviews: reviews ?? this.reviews,
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }
}