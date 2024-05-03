// To parse this JSON data, do
//
//     final chatDetail = chatDetailFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

ChatDetail chatDetailFromJson(String str) =>
    ChatDetail.fromJson(json.decode(str));

String chatDetailToJson(ChatDetail data) => json.encode(data.toJson());

class ChatDetail extends Equatable {
  final String content;
  final DateTime timestamp;
  final int userResponse;
  final String role;

  const ChatDetail({
    required this.content,
    required this.timestamp,
    required this.userResponse,
    required this.role,
  });

  factory ChatDetail.fromJson(Map<String, dynamic> json) => ChatDetail(
        content: json["content"],
        timestamp: DateTime.parse(json["timestamp"]),
        userResponse: json["user_response"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "timestamp":
            "${timestamp.year.toString().padLeft(4, '0')}-${timestamp.month.toString().padLeft(2, '0')}-${timestamp.day.toString().padLeft(2, '0')}",
        "user_response": userResponse,
        "role": role,
      };

  @override
  List<Object?> get props => [timestamp, userResponse, role, content];
}
