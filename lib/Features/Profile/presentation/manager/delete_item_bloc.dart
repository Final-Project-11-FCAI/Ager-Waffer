import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Features/Profile/data/repositories/delete_item_repository.dart';
import 'package:ager_waffer/Features/Profile/presentation/manager/delete_item_state.dart';
import 'package:bloc/bloc.dart';

class DeleteItemBloc extends Bloc<AppEvent, DeleteItemState> {
  DeleteItemBloc() : super(DeleteItemState(status: deleteItemStatus.initial)) {
    on<DeleteItemEvent>(_onDeleteProduct);
  }

  Future<void> _onDeleteProduct(
      DeleteItemEvent event, Emitter<DeleteItemState> emit) async {
    emit(state.copyWith(status: deleteItemStatus.loading));

    var response = await deleteItemRepository.deleteProduct(event.productId);

    if (response.isSuccess!) {
      emit(state.copyWith(
        status: deleteItemStatus.success,
        response: response,
      ));
    } else {
      emit(state.copyWith(
        status: deleteItemStatus.failure,
        failureMessage: response.messageAr,
      ));
    }
  }
}
