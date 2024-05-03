import 'package:answers_ai/model/user/user_model.dart';
import 'package:equatable/equatable.dart';

class CreateUserParams extends Equatable {
  final UserInfo userInfo;

  const CreateUserParams({required this.userInfo});

  @override
  List<Object?> get props => [userInfo];
}
