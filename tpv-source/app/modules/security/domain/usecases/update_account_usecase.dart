// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../models/account_model.dart';
import '../repository/account_repository.dart';

class UpdateAccountUseCase<AccountModelEntity extends AccountModel>
    implements UseCase<AccountModelEntity, UpdateUseCaseAccountParams> {
  final AccountRepository<AccountModelEntity> repository;
  late UpdateUseCaseAccountParams? parameters;
  UpdateAccountUseCase(this.repository);

  @override
  Future<Either<Failure, AccountModelEntity>> call(
    UpdateUseCaseAccountParams? params,
  ) async {
    params = params ?? getParams();
    return await repository.update((parameters = params)!.uuid, params!.entity);
  }

  @override
  UpdateUseCaseAccountParams? getParams() {
    return parameters =
        parameters ?? UpdateUseCaseAccountParams(entity: parameters);
  }

  @override
  UseCase<AccountModelEntity, UpdateUseCaseAccountParams> setParams(
      UpdateUseCaseAccountParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<AccountModelEntity, UpdateUseCaseAccountParams> setParamsFromMap(
      Map params) {
    parameters = UpdateUseCaseAccountParams(entity: params
        // AccountModel.fromJson(
        //     params.map((key, value) => MapEntry(key.toString(), value))),
        // uuid: uuid,
        );
    return this;
  }
}

class UpdateUseCaseAccountParams extends Parametizable {
  dynamic uuid;
  final dynamic entity;
  UpdateUseCaseAccountParams({this.uuid, required this.entity}) : super();
}
