// import 'package:ager_waffer/Base/Helper/app_event.dart';
// import 'package:ager_waffer/Features/Chat/data/repositories/get_messages_repository.dart';
// import 'package:ager_waffer/Features/Chat/presentation/manager/get_messages_state.dart';
// import 'package:bloc/bloc.dart';
//
// class GetMessagesBloc extends Bloc<AppEvent, GetMessagesState> {
//   GetMessagesBloc()
//     : super(const GetMessagesState(messages: [], status: messagesStatus.initial)) {
//     on<GetMessagesEvent>(_onGetMessages);
//   }
//
//   Future<void> _onGetMessages(
//     GetMessagesEvent event,
//     Emitter<GetMessagesState> emit,
//   ) async {
//     emit(state.copyWith(status: messagesStatus.loading));
//
//     try {
//       var response = await getMessagesRepository.getMessages(
//         conversationId: event.conversationId,
//       );
//
//       if (response.isSuccess == true) {
//         print("messages count: ${response.data?.length}");
//
//         emit(
//           state.copyWith(
//             status: messagesStatus.success,
//             messages: response.data ?? [],
//           ),
//         );
//       } else {
//         emit(
//           state.copyWith(
//             status: messagesStatus.failure,
//             failureMessage: response.messageAr ?? '',
//           ),
//         );
//       }
//     } catch (e) {
//       emit(
//         state.copyWith(
//           status: messagesStatus.failure,
//           failureMessage: e.toString(),
//         ),
//       );
//     }
//   }
// }
//
// final GetMessagesBloc messagesBloc = GetMessagesBloc();
