part of 'chat_history_list_bloc.dart';

sealed class ChatHistoryListState extends Equatable {
  const ChatHistoryListState();
}

final class ChatHistoryListInitial extends ChatHistoryListState {
  @override
  List<Object?> get props => [];
}

final class ChatHistoryListFetchedState extends ChatHistoryListState {
  final List<String> chatHistoryList;

  const ChatHistoryListFetchedState({required this.chatHistoryList});
  @override
  List<Object?> get props => [chatHistoryList];
}

final class ChatHistoryListErrorState extends ChatHistoryListState {
  final String message;

  const ChatHistoryListErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}
