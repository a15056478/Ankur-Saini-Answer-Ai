import 'package:answers_ai/domain/firebase/firebase_config.dart';
import 'package:answers_ai/domain/reository/onboarding_repository.dart';
import 'package:answers_ai/model/error/api_response_error.dart';
import 'package:answers_ai/model/prams/login/login_user_params.dart';
import 'package:answers_ai/model/prams/signup/create_user_params.dart';
import 'package:dartz/dartz.dart';

class OnboardingRepositoryImpl extends OnboardingRepository {
  final FierbaseConfig fierbaseConfig;

  OnboardingRepositoryImpl({required this.fierbaseConfig});

  @override
  Future<Either<ApiReponseError, bool>> createUser(
      {required CreateUserParams params}) {
    return fierbaseConfig.createUser(params: params);
  }

  @override
  Future<Either<ApiReponseError, bool>> loginUser(
      {required LoginUserParams params}) {
    return fierbaseConfig.loginUser(params: params);
  }
}
