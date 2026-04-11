import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Features/Chat/data/repositories/all_chats_repository.dart';
import 'package:ager_waffer/Features/Chat/presentation/manager/all_chats_state.dart';
import 'package:bloc/bloc.dart';

class AllChatsBloc extends Bloc<AppEvent, AllChatsState> {

  AllChatsBloc()
      : super(const AllChatsState(
    chats: [],
    status: allChatsStatus.initial,
  )) {
    on<GetAllChatsEvent>(_onGetAllChats);
  }

  Future<void> _onGetAllChats(
      GetAllChatsEvent event,
      Emitter<AllChatsState> emit,
      ) async {

    emit(state.copyWith(status: allChatsStatus.loading));

    try {
      var response = await allChatsRepository.getAllChats();

      if (response.isSuccess == true) {
        print("chats count: ${response.data?.length}");

        emit(state.copyWith(
          status: allChatsStatus.success,
          chats: response.data ?? [],
        ));
      } else {
        emit(state.copyWith(
          status: allChatsStatus.failure,
          failureMessage: response.messageAr ?? "حدث خطأ",
        ));
      }

    } catch (e, stackTrace) {
      print("ERROR: $e");
      print("STACK: $stackTrace");

      String message = "حدث خطأ أثناء تحميل المحادثات";

      if (e.toString().contains("SocketException")) {
        message = "تأكد من اتصال الإنترنت";
      } else if (e.toString().contains("TimeoutException")) {
        message = "انتهت مهلة الاتصال، حاول مرة أخرى";
      }

      emit(state.copyWith(
        status: allChatsStatus.failure,
        failureMessage: message,
      ));
    }
  }}

final AllChatsBloc allChatsBloc = AllChatsBloc();