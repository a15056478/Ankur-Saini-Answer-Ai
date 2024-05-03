import 'package:answers_ai/data/usecase/use_case.dart';
import 'package:answers_ai/domain/reository/onboarding_repository.dart';
import 'package:answers_ai/model/error/api_response_error.dart';
import 'package:answers_ai/model/prams/signup/create_user_params.dart';
import 'package:dartz/dartz.dart';

class CreateUser extends UseCase<bool, CreateUserParams> {
  final OnboardingRepository onboardingRepository;

  CreateUser({required this.onboardingRepository});
  @override
  Future<Either<ApiReponseError, bool>> call(CreateUserParams params) async {
    return await onboardingRepository.createUser(params: params);
  }
}
