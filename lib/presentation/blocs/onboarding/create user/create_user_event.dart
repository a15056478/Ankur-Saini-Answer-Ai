part of 'create_user_bloc.dart';

sealed class CreateUserEvent extends Equatable {
  const CreateUserEvent();
}

class CreateButtonPressedEvent extends CreateUserEvent {
  final CreateUserParams params;

  const CreateButtonPressedEvent({required this.params});

  @override
  List<Object?> get props => [params];
}
