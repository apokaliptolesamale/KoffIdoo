// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../models/account_model.dart';
import '../repository/account_repository.dart';

class ResetPaymentPasswordParams extends Parametizable {
  dynamic id;
  final dynamic entity;
  ResetPaymentPasswordParams({
    this.id,
    required this.entity,
  }) : super();
}

class ResetPaymentPasswordPasswordUseCase<
        AccountModelEntity extends AccountModel>
    implements UseCase<AccountModelEntity, ResetPaymentPasswordParams> {
  final AccountRepository<AccountModelEntity> repository;
  late ResetPaymentPasswordParams? parameters;
  ResetPaymentPasswordPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, AccountModelEntity>> call(
    ResetPaymentPasswordParams? params,
  ) async {
    params = params ?? getParams();
    return await repository.resetPaymentPassword(
        (parameters = params)!.id, params!.entity);
  }

  @override
  ResetPaymentPasswordParams? getParams() {
    return parameters =
        parameters ?? ResetPaymentPasswordParams(entity: parameters);
  }

  @override
  UseCase<AccountModelEntity, ResetPaymentPasswordParams> setParams(
      ResetPaymentPasswordParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<AccountModelEntity, ResetPaymentPasswordParams> setParamsFromMap(
      Map params) {
    parameters = ResetPaymentPasswordParams(entity: params);
    return this;
  }
}
