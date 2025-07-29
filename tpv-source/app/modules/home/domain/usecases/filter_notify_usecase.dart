// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/repository/notify_repository.dart';

FilterUseCaseNotifyParams filterUseCaseNotifyParamsFromMap(
        Map<dynamic, dynamic> params) =>
    FilterUseCaseNotifyParams.fromMap(params);

class FilterNotifyUseCase<NotifyModel>
    implements
        UseCase<EntityModelList<NotifyModel>, FilterUseCaseNotifyParams> {
  final NotifyRepository<NotifyModel> repository;
  FilterUseCaseNotifyParams? parameters;

  FilterNotifyUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<NotifyModel>>> call(
    FilterUseCaseNotifyParams? params,
  ) async {
    return (parameters = params)!.isValid()
        ? await repository.filter(parameters!.toJson())
        : await Future.value(Left(InvalidParamsFailure(
            message:
                "Los parámetros de la búsqueda son vacíos o incorrectos.")));
  }

  Future<Either<Failure, EntityModelList<NotifyModel>>> filter() async {
    return call(getParams()!);
  }

  @override
  FilterUseCaseNotifyParams? getParams() {
    return parameters = parameters ?? FilterUseCaseNotifyParams();
  }

  @override
  UseCase<EntityModelList<NotifyModel>, FilterUseCaseNotifyParams> setParams(
      FilterUseCaseNotifyParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<NotifyModel>, FilterUseCaseNotifyParams>
      setParamsFromMap(Map params) {
    parameters = FilterUseCaseNotifyParams.fromMap(params);
    return this;
  }
}

class FilterUseCaseNotifyParams extends Parametizable {
  final String? idnotify; // id de el caso

  int start = 1;
  int limit = 20;

  FilterUseCaseNotifyParams({
    this.idnotify,
  }) : super();

  factory FilterUseCaseNotifyParams.fromMap(Map<dynamic, dynamic> params) =>
      FilterUseCaseNotifyParams(
          idnotify: params.containsKey("idnotify") ? params["idnotify"] : "");

  @override
  bool isValid() {
    //TODO implementar la validación de cada campo del filtro
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"idnotify": idnotify};

  bool _validate<T>(T? value) {
    return value != null;
  }
}
