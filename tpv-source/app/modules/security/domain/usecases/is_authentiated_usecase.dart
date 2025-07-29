// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';
import 'package:pkce/pkce.dart';

import '../../../../../app/modules/security/domain/models/token_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../../../modules/security/data/repositories/token_repository_impl.dart';

class IsAuthenticateUseCase<EntityModel extends TokenModel>
    implements UseCase<TokenModel, IsAuthenticateUseCaseUserParams> {
  final TokenRepositoryImpl<TokenModel> repository;
  late IsAuthenticateUseCaseUserParams? parameters;

  IsAuthenticateUseCase(this.repository);

  @override
  Future<Either<Failure, TokenModel>> call(
    IsAuthenticateUseCaseUserParams? params,
  ) async {
    parameters = params;
    return await repository.login();
  }

  @override
  IsAuthenticateUseCaseUserParams? getParams() {
    return parameters;
  }

  Future<bool> isAuthenticated() async {
    return (await call(getParams())).fold((l) => false, (r) => r.isValid);
  }

  Future<Either<Failure, void>> savePkcePair(PkcePair pkcePair) {
    return repository.savePkcePair(pkcePair);
  }

  @override
  UseCase<TokenModel, IsAuthenticateUseCaseUserParams> setParams(
      IsAuthenticateUseCaseUserParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<TokenModel, IsAuthenticateUseCaseUserParams> setParamsFromMap(
      Map params) {
    return this;
  }
}

class IsAuthenticateUseCaseUserParams extends Parametizable {
  final int id;
  IsAuthenticateUseCaseUserParams({required this.id}) : super();
}
