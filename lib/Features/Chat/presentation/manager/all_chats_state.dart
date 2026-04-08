import 'package:ager_waffer/Features/Chat/data/models/all_chats_model.dart';
import 'package:equatable/equatable.dart';

enum allChatsStatus { initial, loading, success, failure }

class AllChatsState extends Equatable {
  final List<Data> chats;
  final allChatsStatus status;
  final String failureMessage;

  const AllChatsState({
    required this.chats,
    required this.status,
    this.failureMessage = '',
  });

  @override
  List<Object?> get props => [chats, status, failureMessage];

  AllChatsState copyWith({
    List<Data>? chats,
    allChatsStatus? status,
    String? failureMessage,
  }) {
    return AllChatsState(
      chats: chats ?? this.chats,
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }
}