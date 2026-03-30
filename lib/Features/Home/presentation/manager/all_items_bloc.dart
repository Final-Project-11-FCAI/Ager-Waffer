import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Features/Home/data/repositories/all_items_repository.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/all_items_state.dart';
import 'package:bloc/bloc.dart';

class AllItemsBloc extends Bloc<AppEvent , AllItemsState> {

  AllItemsBloc() :super(AllItemsState(product: [], status: allItemsStatus.initial)){
    on<GetAllItemsEvent>(_onGetAllItems);

  }

  Future<void> _onGetAllItems(GetAllItemsEvent event,
      Emitter<AllItemsState> emit) async {
    emit(state.copyWith(status: allItemsStatus.loading));
    var response = await allItemsRepository.getAllItems();

    if (response.isSuccess! ) {
      print("responseee : ${response.data?.data?.length}");
      emit(state.copyWith(status: allItemsStatus.success,product: response.data?.data ?? []));
    } else {
      emit(state.copyWith(status: allItemsStatus.failure,
          failureMessage: response.messageAr));
    }
  }

}
AllItemsBloc allItemsBloc = new AllItemsBloc();