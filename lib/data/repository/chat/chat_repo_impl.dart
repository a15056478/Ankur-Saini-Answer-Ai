import 'package:answers_ai/domain/firebase/firebase_config.dart';
import 'package:answers_ai/domain/reository/chat_repository.dart';
import 'package:answers_ai/model/chat/chat_detail.dart';
import 'package:answers_ai/model/error/api_response_error.dart';
import 'package:answers_ai/model/prams/chat/add_chat_params.dart';
import 'package:answers_ai/model/prams/chat/chat_history_params.dart';
import 'package:answers_ai/model/prams/chat/chat_list_params.dart';
import 'package:dartz/dartz.dart';

class ChatRepositoryImpl extends ChatRepository {
  final FierbaseConfig firebaseConfig;

  ChatRepositoryImpl({required this.firebaseConfig});

  @override
  Future<Either<ApiReponseError, bool>> addChat(
      {required AddChatParams params}) async {
    return await firebaseConfig.addChat(params: params);
  }

  @override
  Future<Either<ApiReponseError, List<ChatDetail>>> getChat(
      {required ChatListParams params}) async {
    return await firebaseConfig.getChat(params: params);
  }

  @override
  Future<Either<ApiReponseError, List<String>>> getChatHistoryList(
      {required ChatHistoryParams params}) async {
    return await firebaseConfig.getChatHistoryList(params: params);
  }
}
