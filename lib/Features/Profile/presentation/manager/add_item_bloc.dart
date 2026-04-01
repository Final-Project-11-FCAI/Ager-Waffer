
import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Features/Profile/data/repositories/add_item_repository.dart';
import 'package:ager_waffer/Features/Profile/presentation/manager/add_item_state.dart';
import 'package:bloc/bloc.dart';

import '../../data/models/add_item_model.dart';

class AddItemBloc extends Bloc<AppEvent , AddItemState> {

  AddItemBloc() :super(AddItemState(itemData: Data(), status: addItemStatus.initial)){
    on<AddItemEvent>(_onAddItem);

  }

  Future<void> _onAddItem(AddItemEvent event,
      Emitter<AddItemState> emit) async {
    emit(state.copyWith(status: addItemStatus.loading));
    var response = await addItemRepository.addItem(addItemEntity: event.addItemEntity);

    if (response.isSuccess! ) {
      emit(state.copyWith(status: addItemStatus.success,itemData: response.data));
    } else {
      emit(state.copyWith(status: addItemStatus.failure,
          failureMessage: response.messageAr));
    }
  }

}

AddItemBloc addItemBloc = new AddItemBloc();