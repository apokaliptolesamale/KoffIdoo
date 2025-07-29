// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../models/account_model.dart';
import '../repository/account_repository.dart';

class ChangeAccountPasswordParams extends Parametizable {
  dynamic id;
  final dynamic entity;
  ChangeAccountPasswordParams({
    this.id,
    required this.entity,
  }) : super();
}

class ChangeAccountPasswordUseCase<AccountModelEntity extends AccountModel>
    implements UseCase<AccountModelEntity, ChangeAccountPasswordParams> {
  final AccountRepository<AccountModelEntity> repository;
  late ChangeAccountPasswordParams? parameters;
  ChangeAccountPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, AccountModelEntity>> call(
    ChangeAccountPasswordParams? params,
  ) async {
    params = params ?? getParams();
    return await repository.changePasswordAccount(
        (parameters = params)!.id, params!.entity);
  }

  @override
  ChangeAccountPasswordParams? getParams() {
    return parameters =
        parameters ?? ChangeAccountPasswordParams(entity: parameters);
  }

  @override
  UseCase<AccountModelEntity, ChangeAccountPasswordParams> setParams(
      ChangeAccountPasswordParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<AccountModelEntity, ChangeAccountPasswordParams> setParamsFromMap(
      Map params) {
    parameters = ChangeAccountPasswordParams(entity: params);
    return this;
  }
}
