part of 'login_user_bloc.dart';

sealed class LoginUserEvent extends Equatable {
  const LoginUserEvent();
}

class LoginButtonPressedEvent extends LoginUserEvent {
  final LoginUserParams params;

  const LoginButtonPressedEvent({required this.params});

  @override
  List<Object?> get props => [params];
}
