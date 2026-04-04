import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Features/Orders/data/repositories/add_review_repository.dart';
import 'package:ager_waffer/Features/Orders/presentation/manager/add_review_state.dart';
import 'package:bloc/bloc.dart';

class AddReviewBloc extends Bloc<AppEvent, AddReviewState> {

  AddReviewBloc()
      : super(const AddReviewState(
    reviewData: null,
    status: addReviewStatus.initial,
  )) {

    on<AddReviewEvent>(_onAddReview);
  }

  Future<void> _onAddReview(
      AddReviewEvent event,
      Emitter<AddReviewState> emit,
      ) async {

    emit(state.copyWith(status: addReviewStatus.loading));
    var response = await addReviewRepository.addReview(
      reviewType: event.reviewType,
      itemId: event.itemId,
      reviewedUserId: event.reviewedUserId,
      reviewText: event.reviewText,
      rate: event.rate,
    );

    if (response.isSuccess == true) {
      emit(state.copyWith(
        status: addReviewStatus.success,
        reviewData: response.data,
      ));
    } else {
      emit(state.copyWith(
        status: addReviewStatus.failure,
        failureMessage: response.messageAr ?? "حدث خطأ",
      ));
    }
  }
}