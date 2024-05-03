import 'package:answers_ai/data/usecase/onboarding/login_user.dart';
import 'package:answers_ai/model/prams/login/login_user_params.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_user_event.dart';
part 'login_user_state.dart';

class LoginUserBloc extends Bloc<LoginUserEvent, LoginUserState> {
  final LoginUser loginUser;
  LoginUserBloc({required this.loginUser}) : super(LoginUserInitial()) {
    on<LoginButtonPressedEvent>((event, emit) async {
      emit(const LoginVerficationPending());
      final data = await loginUser.call(event.params);

      data.fold((l) => emit(LoginVerficationFailed(error: l.message)),
          (r) => emit(LoginVerficationSuccess(loginUserResponse: r)));
    });
  }
}
