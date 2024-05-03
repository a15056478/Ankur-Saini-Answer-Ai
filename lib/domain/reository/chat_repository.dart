import 'package:answers_ai/model/chat/chat_detail.dart';
import 'package:answers_ai/model/error/api_response_error.dart';
import 'package:answers_ai/model/prams/chat/add_chat_params.dart';
import 'package:answers_ai/model/prams/chat/chat_history_params.dart';
import 'package:answers_ai/model/prams/chat/chat_list_params.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepository {
  Future<Either<ApiReponseError, List<ChatDetail>>> getChat({
    required ChatListParams params,
  });

  Future<Either<ApiReponseError, bool>> addChat(
      {required AddChatParams params});
  Future<Either<ApiReponseError, List<String>>> getChatHistoryList({
    required ChatHistoryParams params,
  });
}
