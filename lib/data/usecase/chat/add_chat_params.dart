import 'package:answers_ai/domain/reository/chat_repository.dart';
import 'package:answers_ai/model/error/api_response_error.dart';
import 'package:answers_ai/model/prams/chat/add_chat_params.dart';
import 'package:dartz/dartz.dart';

import '../use_case.dart';

class AddChat extends UseCase<bool, AddChatParams> {
  final ChatRepository chatRepository;

  AddChat({required this.chatRepository});
  @override
  Future<Either<ApiReponseError, bool>> call(AddChatParams params) async {
    return await chatRepository.addChat(params: params);
  }
}
