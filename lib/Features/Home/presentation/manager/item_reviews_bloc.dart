import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Features/Home/data/repositories/item_reviews_repository.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/item_reviews_state.dart';
import 'package:bloc/bloc.dart';

class ItemReviewBloc extends Bloc<AppEvent, ItemReviewState> {

  ItemReviewBloc() : super(
    const ItemReviewState(
      reviews: [],
      status: itemReviewStatus.initial,
    ),
  ) {
    on<GetItemReviewEvent>(_onGetReviews);
  }

  Future<void> _onGetReviews(
      GetItemReviewEvent event,
      Emitter<ItemReviewState> emit,
      ) async {
    emit(state.copyWith(status: itemReviewStatus.loading));

    var response = await itemReviewRepository.getItemReviews(event.itemId);

    if (response.isSuccess!) {
      print("reviews count : ${response.data?.length}");

      emit(state.copyWith(
        status: itemReviewStatus.success,
        reviews: response.data ?? [],
      ));
    } else {
      emit(state.copyWith(
        status: itemReviewStatus.failure,
        failureMessage: response.messageAr,
      ));
    }
  }
}

ItemReviewBloc reviewBloc = ItemReviewBloc();