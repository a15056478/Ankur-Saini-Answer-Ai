// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo extends Equatable {
  final String email;
  final String token;

  const UserInfo({
    required this.email,
    required this.token,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        email: json["email"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "token": token,
      };

  @override
  List<Object?> get props => [email, token];
}
