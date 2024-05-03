import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:answers_ai/common/theme_text.dart';
import 'package:answers_ai/presentation/blocs/chat/current%20chat/current_chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:readmore/readmore.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({
    super.key,
    required this.content,
    required this.role,
    required this.isLastMessage,
    required this.scrollDown,
    required this.currentChatIndex,
    required this.userResponse,
  });

  final String content;
  final String role;
  final bool isLastMessage;
  final Function scrollDown;
  final int currentChatIndex;
  final int userResponse;

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 16, right: 16, top: 8, bottom: widget.isLastMessage ? 32 : 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: widget.role == 'user'
                    ? Colors.redAccent[200]
                    : Colors.green[600],
                radius: 8.r,
                child: Text(widget.role == 'user' ? 'AS' : 'AI',
                    style: ThemeText.s8w600White),
              ),
              Gap(8.w),
              Expanded(
                child: widget.role != 'user'
                    ? SelectionArea(child: _ChatTextWidget(widget: widget))
                    : SelectionArea(
                        child: Text(
                          widget.content,
                          style: ThemeText.s12w400Black,
                        ),
                      ),
              ),
            ],
          ),
          Gap(widget.role != 'user' && widget.isLastMessage ? 16 : 8),
          widget.role != 'user' && widget.isLastMessage
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        widget.userResponse == 1
                            ? Icons.thumb_up
                            : Icons.thumb_up_alt_outlined,
                        size: 16,
                      ),
                      onPressed: () {
                        BlocProvider.of<CurrentChatBloc>(context).add(
                            CurrentChatHandleFeedbackEvent(
                                userResponse:
                                    widget.userResponse == 1 ? 0 : 1));
                        if (widget.userResponse != 1) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              duration: const Duration(milliseconds: 500),
                              content: Text(
                                "Thank you for your feedback!!!",
                                style: ThemeText.s12w500White,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        widget.userResponse == 2
                            ? Icons.thumb_down
                            : Icons.thumb_down_alt_outlined,
                        size: 16,
                      ),
                      onPressed: () {
                        BlocProvider.of<CurrentChatBloc>(context).add(
                            CurrentChatHandleFeedbackEvent(
                                userResponse:
                                    widget.userResponse == 2 ? 0 : 2));
                        if (widget.userResponse != 2) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              duration: const Duration(milliseconds: 500),
                              content: Text(
                                "Thank you for your feedback!! We will try to improve",
                                style: ThemeText.s12w500White,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.copy_sharp,
                        size: 16.h,
                      ),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: widget.content))
                            .then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              duration: const Duration(milliseconds: 500),
                              content: Text(
                                "Text Copied!!!",
                                style: ThemeText.s12w500White,
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ],
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}

class _ChatTextWidget extends StatefulWidget {
  const _ChatTextWidget({
    required this.widget,
  });

  final ChatWidget widget;

  @override
  State<_ChatTextWidget> createState() => _ChatTextWidgetState();
}

class _ChatTextWidgetState extends State<_ChatTextWidget> {
  bool _isfinished = false;

  @override
  Widget build(BuildContext context) {
    return !_isfinished && widget.widget.isLastMessage
        ? AnimatedTextKit(
            displayFullTextOnTap: true,
            totalRepeatCount: 1,
            onFinished: () {
              setState(() {
                _isfinished = true;
              });
            },
            animatedTexts: [
              TyperAnimatedText(
                widget.widget.content,
                textStyle: ThemeText.s12w500Black,
              ),
            ],
          )
        : ReadMoreText(
            widget.widget.content,
            colorClickableText: Colors.blue[500],
            trimMode: TrimMode.Line,
            trimLines: 10,
            style: ThemeText.s12w500Black,
          );
  }
}
