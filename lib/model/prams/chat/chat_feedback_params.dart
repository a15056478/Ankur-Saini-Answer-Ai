import 'package:answers_ai/model/user/user_model.dart';
import 'package:equatable/equatable.dart';

class ChatFeedbackParams extends Equatable {
  final int feedback;
  final String chatId;
  final UserInfo userInfo;

  const ChatFeedbackParams({
    required this.feedback,
    required this.chatId,
    required this.userInfo,
  });

  @override
  List<Object?> get props => [
        chatId,
        userInfo,
        feedback,
      ];
}
