part of 'create_user_bloc.dart';

sealed class CreateUserState extends Equatable {
  const CreateUserState();
}

final class CreateUserInitial extends CreateUserState {
  @override
  List<Object?> get props => [];
}

class CreateUserVerficationSuccess extends CreateUserState {
  final bool response;
  final UserInfo userInfo;

  const CreateUserVerficationSuccess({
    required this.response,
    required this.userInfo,
  });
  @override
  List<Object?> get props => [response, userInfo];
}

final class CreateUserPending extends CreateUserState {
  @override
  List<Object?> get props => [];
}

class CreateUserVerficationFailed extends CreateUserState {
  final String error;

  const CreateUserVerficationFailed({required this.error});
  @override
  List<Object?> get props => [error];
}
