// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/notify_repository.dart';

GetUseCaseNotifyParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseNotifyParams.fromMap(params);

class GetNotifyUseCase<NotifyModel>
    implements UseCase<NotifyModel, GetUseCaseNotifyParams> {
  final NotifyRepository<NotifyModel> repository;
  late GetUseCaseNotifyParams? parameters;

  GetNotifyUseCase(this.repository);

  @override
  Future<Either<Failure, NotifyModel>> call(
    GetUseCaseNotifyParams? params,
  ) async {
    return await repository.getNotify((parameters = params)!.id);
  }

  @override
  GetUseCaseNotifyParams? getParams() {
    return parameters = parameters ?? GetUseCaseNotifyParams(id: 0);
  }

  @override
  UseCase<NotifyModel, GetUseCaseNotifyParams> setParams(
      GetUseCaseNotifyParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<NotifyModel, GetUseCaseNotifyParams> setParamsFromMap(Map params) {
    parameters = GetUseCaseNotifyParams.fromMap(params);
    return this;
  }
}

class GetUseCaseNotifyParams extends Parametizable {
  final int id;
  GetUseCaseNotifyParams({required this.id}) : super();

  factory GetUseCaseNotifyParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCaseNotifyParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
