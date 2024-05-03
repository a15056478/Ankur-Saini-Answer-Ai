import 'package:answers_ai/model/chat/chat_detail.dart';
import 'package:answers_ai/model/user/user_model.dart';
import 'package:equatable/equatable.dart';

class AddChatParams extends Equatable {
  final UserInfo user;
  final String chatId;
  final ChatDetail chat;
  final bool isFirstChat;

  const AddChatParams(
      {required this.user,
      required this.chatId,
      required this.chat,
      required this.isFirstChat});

  @override
  List<Object?> get props => [user, chatId, chat, isFirstChat];
}
