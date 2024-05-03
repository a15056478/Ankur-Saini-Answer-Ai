import 'package:answers_ai/data/usecase/chat/get_chat_history.dart';
import 'package:answers_ai/model/prams/chat/chat_history_params.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_history_list_event.dart';
part 'chat_history_list_state.dart';

class ChatHistoryListBloc
    extends Bloc<ChatHistoryListEvent, ChatHistoryListState> {
  final GetChatHistory getChatHistory;
  ChatHistoryListBloc({
    required this.getChatHistory,
  }) : super(ChatHistoryListInitial()) {
    on<ChatHistoryListFetchEvent>((event, emit) async {
      final data = await getChatHistory.call(event.params);

      data.fold((l) => emit(ChatHistoryListErrorState(message: l.message)),
          (r) => emit(ChatHistoryListFetchedState(chatHistoryList: r)));
    });
  }
}
