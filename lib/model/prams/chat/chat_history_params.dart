import 'package:answers_ai/model/user/user_model.dart';
import 'package:equatable/equatable.dart';

class ChatHistoryParams extends Equatable {
  final UserInfo user;

  const ChatHistoryParams({required this.user});

  @override
  List<Object?> get props => [user];
}
