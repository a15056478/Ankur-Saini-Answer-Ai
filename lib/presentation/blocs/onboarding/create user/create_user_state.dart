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

  const CreateUserVerficationSuccess({required this.response});
  @override
  List<Object?> get props => [response];
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
