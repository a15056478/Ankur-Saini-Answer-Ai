import 'package:answers_ai/model/user/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/usecase/onboarding/create_user.dart';
import '../../../../model/prams/signup/create_user_params.dart';

part 'create_user_event.dart';
part 'create_user_state.dart';

class CreateUserBloc extends Bloc<CreateUserEvent, CreateUserState> {
  final CreateUser createUser;
  CreateUserBloc({required this.createUser}) : super(CreateUserInitial()) {
    on<CreateButtonPressedEvent>((event, emit) async {
      emit(CreateUserPending());
      final data = await createUser.call(event.params);

      data.fold(
          (l) => emit(CreateUserVerficationFailed(error: l.message)),
          (r) => emit(CreateUserVerficationSuccess(
                response: r,
                userInfo: event.params.userInfo,
              )));
    });
  }
}
