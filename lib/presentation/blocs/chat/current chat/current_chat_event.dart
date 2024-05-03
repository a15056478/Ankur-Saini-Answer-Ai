part of 'current_chat_bloc.dart';

sealed class CurrentChatEvent extends Equatable {
  const CurrentChatEvent();
}

class CurrentChatAddMessageEvent extends CurrentChatEvent {
  final AddChatParams params;

  const CurrentChatAddMessageEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

class CurrentChatShowPreviousChatEvent extends CurrentChatEvent {
  final ChatListParams params;

  const CurrentChatShowPreviousChatEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

class CurrentChatShowNewChatEvent extends CurrentChatEvent {
  const CurrentChatShowNewChatEvent();

  @override
  List<Object?> get props => [];
}

class CurrentChatHandleFeedbackEvent extends CurrentChatEvent {
  final int userResponse;

  const CurrentChatHandleFeedbackEvent({required this.userResponse});

  @override
  List<Object?> get props => [userResponse];
}
