// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../models/notify_model.dart';
import '../repository/notify_repository.dart';

class UpdateNotifyUseCase<NotifyModelEntity extends NotifyModel>
    implements UseCase<NotifyModelEntity, UpdateUseCaseNotifyParams> {
  final NotifyRepository<NotifyModelEntity> repository;
  late UpdateUseCaseNotifyParams? parameters;
  UpdateNotifyUseCase(this.repository);

  @override
  Future<Either<Failure, NotifyModelEntity>> call(
    UpdateUseCaseNotifyParams? params,
  ) async {
    return await repository.update((parameters = params)!.id, params!.entity);
  }

  @override
  UpdateUseCaseNotifyParams? getParams() {
    return parameters = parameters ??
        UpdateUseCaseNotifyParams(id: 0, entity: NotifyModel.fromEmpty());
  }

  @override
  UseCase<NotifyModelEntity, UpdateUseCaseNotifyParams> setParams(
      UpdateUseCaseNotifyParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<NotifyModelEntity, UpdateUseCaseNotifyParams> setParamsFromMap(
      Map params) {
    return this;
  }
}

class UpdateUseCaseNotifyParams extends Parametizable {
  final dynamic id;
  final NotifyModel entity;
  UpdateUseCaseNotifyParams({
    required this.id,
    required this.entity,
  }) : super();
}
