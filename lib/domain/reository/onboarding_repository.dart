import 'package:answers_ai/model/error/api_response_error.dart';
import 'package:answers_ai/model/prams/login/login_user_params.dart';
import 'package:answers_ai/model/prams/signup/create_user_params.dart';
import 'package:dartz/dartz.dart';

abstract class OnboardingRepository {
  Future<Either<ApiReponseError, bool>> createUser(
      {required CreateUserParams params});
  Future<Either<ApiReponseError, bool>> loginUser(
      {required LoginUserParams params});
}
