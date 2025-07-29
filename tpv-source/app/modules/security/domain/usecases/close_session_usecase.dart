// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../../../modules/security/data/repositories/token_repository_impl.dart';

class CloseSessionUseCase
    implements UseCase<dynamic, CloseSessionUseCaseUserParams> {
  final TokenRepositoryImpl repository;
  late CloseSessionUseCaseUserParams? parameters;
  CloseSessionUseCase(this.repository);

  @override
  Future<Either<Failure, dynamic>> call(
    CloseSessionUseCaseUserParams? params,
  ) async {
    parameters = params;
    return await repository.logOut();
  }

  @override
  CloseSessionUseCaseUserParams? getParams() {
    return parameters;
  }

  @override
  UseCase<dynamic, CloseSessionUseCaseUserParams> setParams(
      CloseSessionUseCaseUserParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<dynamic, CloseSessionUseCaseUserParams> setParamsFromMap(Map params) {
    return this;
  }
}

class CloseSessionUseCaseUserParams extends Parametizable {
  final int id;
  CloseSessionUseCaseUserParams({required this.id}) : super();
}
