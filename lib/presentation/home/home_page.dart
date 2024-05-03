// ignore_for_file: prefer_final_fields

import 'package:answers_ai/common/theme_text.dart';
import 'package:answers_ai/model/prams/chat/add_chat_params.dart';
import 'package:answers_ai/model/prams/chat/chat_history_params.dart';
import 'package:answers_ai/model/prams/chat/chat_list_params.dart';
import 'package:answers_ai/presentation/blocs/chat/chat%20history%20list/chat_history_list_bloc.dart';
import 'package:answers_ai/presentation/blocs/chat/current%20chat/current_chat_bloc.dart';
import 'package:answers_ai/presentation/login/login_page.dart';
import 'package:answers_ai/widgets/chat_widget.dart';
import 'package:answers_ai/model/chat/chat_detail.dart';
import 'package:answers_ai/model/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  final UserInfo userInfo;
  const HomePage({
    super.key,
    required this.userInfo,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //antroic api
  String chatId = '';
  List<String> chatHistoryIds = [];
  bool foundError = false;
  late TextEditingController _textEditingController;
  ScrollController _scrollController = ScrollController();
  late CurrentChatBloc _currentChatBloc;

  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  /// To Click from menu
  void handleClick(int item) {
    BlocProvider.of<ChatHistoryListBloc>(context).add(ChatHistoryListFetchEvent(
      params: ChatHistoryParams(
        user: widget.userInfo,
      ),
    ));
    switch (item) {
      case 0:
        showModalBottomSheet(
            isScrollControlled: false,
            context: context,
            builder: (context) =>
                BlocBuilder<ChatHistoryListBloc, ChatHistoryListState>(
                  builder: (context, state) {
                    return SizedBox(
                      height: 300.h,
                      width: 375.w,
                      child: state is ChatHistoryListFetchedState
                          ? ListView.separated(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: state.chatHistoryList.length,
                              itemBuilder: (context, index) => ListTile(
                                onTap: () => updateChatView(
                                    state.chatHistoryList[index]),
                                title: Text(
                                  DateFormat().format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                      int.parse(
                                        state.chatHistoryList[index],
                                      ),
                                    ),
                                  ),
                                  style: ThemeText.s14w500Black,
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 16.h,
                                ),
                              ),
                            )
                          : Center(
                              child: Text(
                                'No History Found',
                                style: ThemeText.s14w500Black,
                              ),
                            ),
                    );
                  },
                ));
        break;
      case 1:
        startNewChat();
        break;
      case 2:
        logout();
    }
  }

  /// Start new fresh chat
  startNewChat() {
    _currentChatBloc.add(const CurrentChatShowNewChatEvent());
  }

  ///To logout from app
  logout() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (contex) => const LoginPage()),
        (route) => false);
  }

  /// To show previous selected chat view
  updateChatView(String chatId) async {
    Navigator.pop(context);
    _currentChatBloc.add(CurrentChatShowPreviousChatEvent(
        params: ChatListParams(user: widget.userInfo, chatId: chatId)));
  }

  @override
  void initState() {
    _currentChatBloc = BlocProvider.of<CurrentChatBloc>(context)
      ..add(const CurrentChatShowNewChatEvent());
    _textEditingController = TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: Colors.white,
        actions: <Widget>[
          PopupMenuButton<int>(
            color: Colors.white,
            onSelected: (item) => handleClick(item),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(value: 0, child: Text('HISTORY')),
              const PopupMenuItem<int>(value: 1, child: Text('NEW CHAT')),
              const PopupMenuItem<int>(value: 2, child: Text('LOGOUT')),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<CurrentChatBloc, CurrentChatState>(
          listener: (context, state) {
            if (state is CurrentChatUpdated) {
              Future.delayed(
                  const Duration(
                    milliseconds: 500,
                  ), () {
                scrollDown();
              });
            }
            if (state is CurrentChatUpdateFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 2),
                  content: Text(
                    "Something went wrong!! Please try agin after sometime. we really appolosige for this.",
                    style: ThemeText.s12w500White,
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    //To make the text selectable inside chat area
                    child: ListView.builder(
                        controller: _scrollController,
                        itemCount: state.chatList.length,
                        itemBuilder: (context, index) => ChatWidget(
                              userResponse: state.chatList[index].userResponse,
                              currentChatIndex: index,
                              scrollDown: scrollDown,
                              isLastMessage: index == state.chatList.length - 1,
                              role: state.chatList[index].role,
                              content: state.chatList[index].content,
                            )),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 8.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: _textEditingController,
                            minLines: 1,
                            maxLines: 3,
                            decoration: InputDecoration(
                              suffixIconConstraints: const BoxConstraints(
                                  maxHeight: 16, maxWidth: 70),
                              suffixIcon: state is CurrentChatUpdating
                                  ? SpinKitThreeBounce(
                                      size: 16.r,
                                      color: Colors.green,
                                    )
                                  : const SizedBox(),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  40.r,
                                ),
                              ),
                              hintText: state.chatList.isEmpty
                                  ? 'Hi! How can we help you today?'
                                  : null,
                              hintStyle: ThemeText.s12w300BlackWithOpaicy70,
                            ),
                          ),
                        ),
                        Gap(16.h),
                        CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          radius: 16.r,
                          child: IconButton(
                              onPressed: () {
                                if (_textEditingController.text.isNotEmpty &&
                                    state is! CurrentChatUpdating) {
                                  final chatDetails = ChatDetail(
                                    content: _textEditingController.text,
                                    timestamp: DateTime.now(),
                                    userResponse: 0,
                                    role: 'user',
                                  );
                                  if (state.chatList.isEmpty) {
                                    chatId = DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString();

                                    _currentChatBloc.add(
                                        CurrentChatAddMessageEvent(
                                            params: AddChatParams(
                                                isFirstChat: true,
                                                user: widget.userInfo,
                                                chatId: chatId,
                                                chat: chatDetails)));
                                  } else {
                                    _currentChatBloc.add(
                                        CurrentChatAddMessageEvent(
                                            params: AddChatParams(
                                                isFirstChat: false,
                                                user: widget.userInfo,
                                                chatId: chatId,
                                                chat: chatDetails)));
                                  }

                                  _textEditingController.clear();
                                  scrollDown();
                                }
                                scrollDown();
                              },
                              icon: Icon(
                                state is CurrentChatUpdating
                                    ? Icons.stop
                                    : Icons.arrow_upward_outlined,
                                color: Colors.white,
                                size: 16.h,
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
