import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Features/Home/data/repositories/reviews_about_user_repository.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/reviews_about_user_state.dart';
import 'package:bloc/bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ReviewsAboutUserBloc extends Bloc<AppEvent, ReviewsAboutUserState> {

  ReviewsAboutUserBloc()
      : super(const ReviewsAboutUserState(
    reviews: [],
    status: reviewsAboutUserStatus.initial,
  )) {

    on<GetReviewsAboutUserEvent>(_onGetUserReviews);
  }

  Future<void> _onGetUserReviews(
      GetReviewsAboutUserEvent event,
      Emitter<ReviewsAboutUserState> emit,
      ) async {

    emit(state.copyWith(status: reviewsAboutUserStatus.loading));

    try {
      var response = await reviewsAboutUserRepository.getUserReviews(event.userId);

      if (response.isSuccess == true) {
        print("reviews count: ${response.data?.length}");

        emit(state.copyWith(
          status: reviewsAboutUserStatus.success,
          reviews: response.data ?? [],
        ));
      } else {
        emit(state.copyWith(
          status: reviewsAboutUserStatus.failure,
          failureMessage: response.messageAr ?? kSomethingWrong.tr(),
        ));
      }

    } catch (e) {
      print("ERROR: $e");

      emit(state.copyWith(
        status: reviewsAboutUserStatus.failure,
        failureMessage: kServerError.tr(),
      ));
    }
  }
}

ReviewsAboutUserBloc reviewsAboutUserBloc = ReviewsAboutUserBloc();