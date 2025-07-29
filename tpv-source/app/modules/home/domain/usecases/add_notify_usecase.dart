// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/notify_repository.dart';

AddUseCaseNotifyParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    AddUseCaseNotifyParams.fromMap(params);

class AddNotifyUseCase<NotifyModel>
    implements UseCase<NotifyModel, AddUseCaseNotifyParams> {
  final NotifyRepository<NotifyModel> repository;
  late AddUseCaseNotifyParams? parameters;

  AddNotifyUseCase(this.repository);

  @override
  Future<Either<Failure, NotifyModel>> call(
    AddUseCaseNotifyParams? params,
  ) async {
    return await repository.add(parameters = params);
  }

  @override
  AddUseCaseNotifyParams? getParams() {
    return parameters = parameters ?? AddUseCaseNotifyParams(id: 0);
  }

  @override
  UseCase<NotifyModel, AddUseCaseNotifyParams> setParams(
      AddUseCaseNotifyParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<NotifyModel, AddUseCaseNotifyParams> setParamsFromMap(Map params) {
    parameters = AddUseCaseNotifyParams.fromMap(params);
    return this;
  }
}

class AddUseCaseNotifyParams extends Parametizable {
  final int id;
  AddUseCaseNotifyParams({required this.id}) : super();

  factory AddUseCaseNotifyParams.fromMap(Map<dynamic, dynamic> params) =>
      AddUseCaseNotifyParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
