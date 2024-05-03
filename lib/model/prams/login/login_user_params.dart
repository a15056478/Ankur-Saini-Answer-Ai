import 'package:answers_ai/model/user/user_model.dart';
import 'package:equatable/equatable.dart';

class LoginUserParams extends Equatable {
  final UserInfo userInfo;

  const LoginUserParams({required this.userInfo});

  @override
  List<Object?> get props => [userInfo];
}
