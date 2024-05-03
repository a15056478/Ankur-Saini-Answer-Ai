import 'package:answers_ai/model/error/api_response_error.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Params> {
  Future<Either<ApiReponseError, Type>> call(Params params);
}
