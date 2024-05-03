import 'package:answers_ai/data/usecase/use_case.dart';
import 'package:answers_ai/domain/reository/chat_repository.dart';
import 'package:answers_ai/model/chat/chat_detail.dart';
import 'package:answers_ai/model/error/api_response_error.dart';
import 'package:answers_ai/model/prams/chat/chat_list_params.dart';
import 'package:dartz/dartz.dart';

class GetChat extends UseCase<List<ChatDetail>, ChatListParams> {
  final ChatRepository chatRepository;

  GetChat({required this.chatRepository});
  @override
  Future<Either<ApiReponseError, List<ChatDetail>>> call(
      ChatListParams params) async {
    return await chatRepository.getChat(params: params);
  }
}
