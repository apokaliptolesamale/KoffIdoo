// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/models/notify_model.dart';
import '../repository/notify_repository.dart';

DeleteUseCaseNotifyParams deleteUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    DeleteUseCaseNotifyParams.fromMap(params);

class DeleteNotifyUseCase<NotifyModelEntity extends NotifyModel>
    implements UseCase<NotifyModelEntity, DeleteUseCaseNotifyParams> {
  final NotifyRepository<NotifyModelEntity> repository;

  late DeleteUseCaseNotifyParams? parameters;

  DeleteNotifyUseCase(this.repository);

  @override
  Future<Either<Failure, NotifyModelEntity>> call(
    DeleteUseCaseNotifyParams? params,
  ) async {
    return await repository.delete((parameters = params)!.id);
  }

  @override
  DeleteUseCaseNotifyParams? getParams() {
    return parameters = parameters ?? DeleteUseCaseNotifyParams(id: 0);
  }

  @override
  UseCase<NotifyModelEntity, DeleteUseCaseNotifyParams> setParams(
      DeleteUseCaseNotifyParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<NotifyModelEntity, DeleteUseCaseNotifyParams> setParamsFromMap(
      Map params) {
    parameters = DeleteUseCaseNotifyParams.fromMap(params);
    return this;
  }
}

class DeleteUseCaseNotifyParams extends Parametizable {
  final int id;
  DeleteUseCaseNotifyParams({required this.id}) : super();

  factory DeleteUseCaseNotifyParams.fromMap(Map<dynamic, dynamic> params) =>
      DeleteUseCaseNotifyParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
