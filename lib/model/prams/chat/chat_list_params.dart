import 'package:answers_ai/model/user/user_model.dart';
import 'package:equatable/equatable.dart';

class ChatListParams extends Equatable {
  final UserInfo user;
  final String chatId;

  const ChatListParams({required this.user, required this.chatId});

  @override
  List<Object?> get props => [user, chatId];
}
