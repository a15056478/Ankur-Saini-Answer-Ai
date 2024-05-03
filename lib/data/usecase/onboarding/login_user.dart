import 'package:dartz/dartz.dart';

import '../../../domain/reository/onboarding_repository.dart';
import '../../../model/error/api_response_error.dart';
import '../../../model/prams/login/login_user_params.dart';
import '../use_case.dart';

class LoginUser extends UseCase<bool, LoginUserParams> {
  final OnboardingRepository onboardingRepository;

  LoginUser({required this.onboardingRepository});
  @override
  Future<Either<ApiReponseError, bool>> call(LoginUserParams params) async {
    return await onboardingRepository.loginUser(params: params);
  }
}
