part of 'login_user_bloc.dart';

sealed class LoginUserState extends Equatable {
  const LoginUserState();
}

final class LoginUserInitial extends LoginUserState {
  @override
  List<Object?> get props => [];
}

class LoginVerficationSuccess extends LoginUserState {
  final bool loginUserResponse;
  final UserInfo userInfo;

  const LoginVerficationSuccess({
    required this.loginUserResponse,
    required this.userInfo,
  });
  @override
  List<Object?> get props => [loginUserResponse, userInfo];
}

class LoginVerficationPending extends LoginUserState {
  const LoginVerficationPending();
  @override
  List<Object?> get props => [];
}

class LoginVerficationFailed extends LoginUserState {
  final String error;

  const LoginVerficationFailed({required this.error});
  @override
  List<Object?> get props => [error];
}
