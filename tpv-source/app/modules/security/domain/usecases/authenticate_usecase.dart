// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';
import 'package:pkce/pkce.dart';

import '/globlal_constants.dart';
import '../../../../../app/core/services/manager_authorization_service.dart';
import '../../../../../app/modules/security/domain/models/token_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../../../modules/security/data/repositories/token_repository_impl.dart';

class AuthenticateUseCase<EntityModel extends TokenModel>
    implements UseCase<TokenModel, AuthenticateUseCaseUserParams> {
  final TokenRepositoryImpl<TokenModel> repository;
  late AuthenticateUseCaseUserParams? parameters;

  final auth = ManagerAuthorizationService().get(defaultIdpKey);

  AuthenticateUseCase(this.repository);

  @override
  Future<Either<Failure, TokenModel>> call(
    AuthenticateUseCaseUserParams? params,
  ) async {
    parameters = params;
    return await repository.login();
  }

  @override
  AuthenticateUseCaseUserParams? getParams() {
    return parameters;
  }

  Future<bool> isAuthenticated() =>
      auth != null ? auth!.isAuthenticated() : Future.value(false);

  Future<Either<Failure, void>> savePkcePair(PkcePair pkcePair) {
    return repository.savePkcePair(pkcePair);
  }

  @override
  UseCase<TokenModel, AuthenticateUseCaseUserParams> setParams(
      AuthenticateUseCaseUserParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<TokenModel, AuthenticateUseCaseUserParams> setParamsFromMap(
      Map params) {
    return this;
  }
}

class AuthenticateUseCaseUserParams extends Parametizable {
  final int id;
  AuthenticateUseCaseUserParams({required this.id}) : super();
}
