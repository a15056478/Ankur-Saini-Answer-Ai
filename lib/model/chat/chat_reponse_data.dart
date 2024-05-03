// To parse this JSON data, do
//
//     final chatResponseData = chatResponseDataFromJson(jsonString);

import 'dart:convert';

ChatResponseData chatResponseDataFromJson(String str) =>
    ChatResponseData.fromJson(json.decode(str));

String chatResponseDataToJson(ChatResponseData data) =>
    json.encode(data.toJson());

class ChatResponseData {
  final String id;
  final String type;
  final String role;
  final String model;
  final dynamic stopSequence;
  final Usage usage;
  final List<Content> content;
  final String stopReason;

  ChatResponseData({
    required this.id,
    required this.type,
    required this.role,
    required this.model,
    required this.stopSequence,
    required this.usage,
    required this.content,
    required this.stopReason,
  });

  factory ChatResponseData.fromJson(Map<String, dynamic> json) =>
      ChatResponseData(
        id: json["id"],
        type: json["type"],
        role: json["role"],
        model: json["model"],
        stopSequence: json["stop_sequence"],
        usage: Usage.fromJson(json["usage"]),
        content:
            List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
        stopReason: json["stop_reason"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "role": role,
        "model": model,
        "stop_sequence": stopSequence,
        "usage": usage.toJson(),
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "stop_reason": stopReason,
      };
}

class Content {
  final String type;
  final String text;

  Content({
    required this.type,
    required this.text,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        type: json["type"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "text": text,
      };
}

class Usage {
  final int inputTokens;
  final int outputTokens;

  Usage({
    required this.inputTokens,
    required this.outputTokens,
  });

  factory Usage.fromJson(Map<String, dynamic> json) => Usage(
        inputTokens: json["input_tokens"],
        outputTokens: json["output_tokens"],
      );

  Map<String, dynamic> toJson() => {
        "input_tokens": inputTokens,
        "output_tokens": outputTokens,
      };
}
