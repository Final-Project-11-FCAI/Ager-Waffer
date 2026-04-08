// import 'package:ager_waffer/Features/Chat/data/models/messages_model.dart';
// import 'package:equatable/equatable.dart';
//
// enum messagesStatus { initial, loading, success, failure }
//
// class GetMessagesState extends Equatable {
//   final List<MessageData> messages;
//   final messagesStatus status;
//   final String failureMessage;
//
//   const GetMessagesState({
//     required this.messages,
//     required this.status,
//     this.failureMessage = '',
//   });
//
//   @override
//   List<Object?> get props => [messages, status, failureMessage];
//
//   GetMessagesState copyWith({
//     List<MessageData>? messages,
//     messagesStatus? status,
//     String? failureMessage,
//   }) {
//     return GetMessagesState(
//       messages: messages ?? this.messages,
//       status: status ?? this.status,
//       failureMessage: failureMessage ?? this.failureMessage,
//     );
//   }
// }