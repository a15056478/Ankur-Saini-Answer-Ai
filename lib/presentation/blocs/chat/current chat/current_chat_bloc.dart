// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:answers_ai/data/usecase/chat/add_chat.dart';
import 'package:answers_ai/data/usecase/chat/get_chat.dart';
import 'package:answers_ai/model/chat/chat_reponse_data.dart';
import 'package:answers_ai/model/prams/chat/add_chat_params.dart';
import 'package:anthropic_dart/anthropic_dart.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../model/chat/chat_detail.dart';
import '../../../../model/prams/chat/chat_list_params.dart';

part 'current_chat_event.dart';
part 'current_chat_state.dart';

class CurrentChatBloc extends Bloc<CurrentChatEvent, CurrentChatState> {
  final GetChat getChat;
  final AddChat addChat;
  CurrentChatBloc({
    required this.addChat,
    required this.getChat,
  }) : super(const CurrentChatInitialState(chatList: [])) {
    on<CurrentChatAddMessageEvent>((event, emit) async {
      emit(CurrentChatUpdating(chatList: state.chatList));

      List<ChatDetail> _tempList = [];
      _tempList.addAll(state.chatList);
      _tempList.add(event.params.chat);
      addChat.call(event.params);
      emit(CurrentChatUpdated(chatList: _tempList));
      emit(CurrentChatUpdating(chatList: state.chatList));
      try {
        AnthropicService service = AnthropicService(
          dotenv.env['enthropicKey']!,
          model: "claude-3-opus-20240229",
        );
        var request = Request();
        List<Message> _messages = [];
        if (state.chatList.length > 2) {
          _messages = List.generate(
              3,
              (index) => Message(
                  role: state.chatList[state.chatList.length + index - 3].role,
                  content: state
                      .chatList[state.chatList.length + index - 3].content));
        } else {
          _messages
              .add(Message(role: 'user', content: state.chatList.last.content));
        }

        request.model = service.model;
        request.maxTokens = 1024;
        request.messages = _messages;

        final response = await service.sendRequest(request: request);

        final data = chatResponseDataFromJson(jsonEncode(response));
        final chatDetails = ChatDetail(
            content: data.content.first.text,
            timestamp: DateTime.now(),
            userResponse: 0,
            role: data.role);
        List<ChatDetail> _aitempList = [];
        _aitempList.addAll(state.chatList);
        _aitempList.add(chatDetails);
        addChat.call(
          AddChatParams(
            user: event.params.user,
            chatId: event.params.chatId,
            chat: chatDetails,
            isFirstChat: false,
          ),
        );
        emit(CurrentChatUpdated(chatList: _aitempList));
      } catch (e) {
        emit(
          CurrentChatUpdateFailed(
            chatList: state.chatList,
            message: 'Something went wrong',
          ),
        );
      }
    });

    on<CurrentChatShowPreviousChatEvent>((event, emit) async {
      emit(CurrentChatUpdating(chatList: state.chatList));
      final data = await getChat.call(event.params);
      data.fold(
          (l) => emit(CurrentChatUpdateFailed(
              chatList: state.chatList, message: l.message)),
          (r) => emit(CurrentChatUpdated(chatList: r)));
    });

    on<CurrentChatShowNewChatEvent>(
      (event, emit) => emit(
        const CurrentChatUpdated(
          chatList: [],
        ),
      ),
    );
    on<CurrentChatHandleFeedbackEvent>((event, emit) {
      emit(CurrentChatUpdating(chatList: state.chatList));
      List<ChatDetail> _chat = state.chatList;
      ChatDetail _tempChatDetail = _chat.last;
      _chat.removeLast();
      _chat.add(
        ChatDetail(
          content: _tempChatDetail.content,
          timestamp: _tempChatDetail.timestamp,
          userResponse: event.userResponse,
          role: _tempChatDetail.role,
        ),
      );

      emit(CurrentChatUpdated(chatList: _chat));
    });
  }
}
