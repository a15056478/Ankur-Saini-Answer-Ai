import 'package:answers_ai/data/usecase/use_case.dart';
import 'package:answers_ai/domain/reository/chat_repository.dart';
import 'package:answers_ai/model/error/api_response_error.dart';
import 'package:answers_ai/model/prams/chat/chat_history_params.dart';
import 'package:dartz/dartz.dart';

class GetChatHistory extends UseCase<List<String>, ChatHistoryParams> {
  final ChatRepository chatRepository;

  GetChatHistory({required this.chatRepository});
  @override
  Future<Either<ApiReponseError, List<String>>> call(
      ChatHistoryParams params) async {
    return await chatRepository.getChatHistoryList(params: params);
  }
}
