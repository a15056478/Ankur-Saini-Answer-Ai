part of 'current_chat_bloc.dart';

sealed class CurrentChatState extends Equatable {
  final List<ChatDetail> chatList;
  const CurrentChatState({required this.chatList});
}

final class CurrentChatInitialState extends CurrentChatState {
  const CurrentChatInitialState({required super.chatList});

  @override
  List<Object?> get props => [
        chatList.length,
        chatList,
      ];
}

final class CurrentChatUpdated extends CurrentChatState {
  const CurrentChatUpdated({required super.chatList});

  @override
  List<Object?> get props => [
        chatList.length,
        chatList,
      ];
}

final class CurrentChatUpdating extends CurrentChatState {
  const CurrentChatUpdating({required super.chatList});

  @override
  List<Object?> get props => [
        chatList.length,
        chatList,
      ];
}

final class CurrentChatUpdateFailed extends CurrentChatState {
  final String message;
  const CurrentChatUpdateFailed({
    required super.chatList,
    required this.message,
  });

  @override
  List<Object?> get props => [
        chatList.length,
        chatList,
      ];
}
