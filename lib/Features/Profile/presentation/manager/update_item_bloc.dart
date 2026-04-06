import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Features/Profile/data/repositories/update_item_repository.dart';
import 'package:ager_waffer/Features/Profile/presentation/manager/update_item_state.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:bloc/bloc.dart';

import '../../data/models/update_item_model.dart';

class UpdateItemBloc extends Bloc<AppEvent, UpdateItemState> {

  UpdateItemBloc()
      : super(UpdateItemState(itemData: Data(), status: updateItemStatus.initial)) {
    on<UpdateItemEvent>(_onUpdateItem);
  }

  Future<void> _onUpdateItem(
      UpdateItemEvent event,
      Emitter<UpdateItemState> emit) async {

    emit(state.copyWith(status: updateItemStatus.loading));

    try {
      final response = await updateItemRepository.updateItem(
        productId: event.productId,
        addItemEntity: event.addItemEntity,
      );

      if (response.isSuccess == true) {
        emit(state.copyWith(
          status: updateItemStatus.success,
          itemData: response.data ?? Data(),
        ));
      } else {
        emit(state.copyWith(
          status: updateItemStatus.failure,
          failureMessage: response.messageAr ??
              response.messageEn ??
              kUpdateError.tr(),
        ));
      }
    } catch (_) {
      emit(state.copyWith(
        status: updateItemStatus.failure,
        failureMessage: kUpdateError.tr(),
      ));
    }
  }
}

UpdateItemBloc updateItemBloc = UpdateItemBloc();