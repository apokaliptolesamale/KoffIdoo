// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/use_case.dart';

import '../models/account_model.dart';
import '../models/destinatario_model.dart';
import '../repository/account_repository.dart';

class GetDestinatariosUseCaseParams extends Parametizable {
  dynamic id;
  final dynamic entity;
  GetDestinatariosUseCaseParams({this.id, required this.entity}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory GetDestinatariosUseCaseParams.fromMap(Map<dynamic, dynamic> params) =>
      GetDestinatariosUseCaseParams(
          id: params.containsKey("id") ? params["id"] : 0,
          entity: params.containsKey("username") ? params["username"] : "");

  @override
  Map<String, dynamic> toJson() => {"id": id};
}

class GetDestinatariosUseCase<DestinatarioModelEntity extends DestinatarioModel>
    implements
        UseCase<EntityModelList<DestinatarioModel>,
            GetDestinatariosUseCaseParams> {
  final AccountRepository<AccountModel> repository;
  late GetDestinatariosUseCaseParams? parameters;
  GetDestinatariosUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<DestinatarioModel>>> call(
    GetDestinatariosUseCaseParams? params,
  ) async {
    params = params ?? getParams();
    return await repository.getDestinatarios(params!.entity);
  }

  @override
  GetDestinatariosUseCaseParams? getParams() {
    return parameters =
        parameters ?? GetDestinatariosUseCaseParams(entity: parameters);
  }

  @override
  UseCase<EntityModelList<DestinatarioModel>, GetDestinatariosUseCaseParams>
      setParams(GetDestinatariosUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<DestinatarioModel>, GetDestinatariosUseCaseParams>
      setParamsFromMap(Map params) {
    parameters = GetDestinatariosUseCaseParams(entity: params);
    return this;
  }
}
