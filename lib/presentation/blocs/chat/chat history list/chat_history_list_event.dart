part of 'chat_history_list_bloc.dart';

sealed class ChatHistoryListEvent extends Equatable {
  const ChatHistoryListEvent();
}

class ChatHistoryListFetchEvent extends ChatHistoryListEvent {
  final ChatHistoryParams params;

  const ChatHistoryListFetchEvent({required this.params});

  @override
  List<Object?> get props => [params];
}
