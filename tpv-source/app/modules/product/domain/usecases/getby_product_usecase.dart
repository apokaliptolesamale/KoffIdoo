// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '/app/core/services/logger_service.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';
import '../../../../core/interfaces/use_case.dart';

class GetProductByFieldUseCase<Entity extends EntityModel>
    implements
        UseCase<EntityModelList<Entity>, GetProductByFieldUseCaseParams> {
  final Repository<Entity> repository;
  GetProductByFieldUseCaseParams parameters = GetProductByFieldUseCaseParams();
  GetProductByFieldUseCase(this.repository);

  GetProductByFieldUseCaseParams buildParams({
    String id = "",
    String idOrder = "",
    String name = "",
  }) {
    return GetProductByFieldUseCaseParams(
      idOrder: idOrder,
      id: id,
      name: name,
    );
  }

  @override
  Future<Either<Failure, EntityModelList<Entity>>> call(
    GetProductByFieldUseCaseParams? params,
  ) async {
    final filter = (params ?? parameters);
    log("Buscando productos de la orden ${filter.isEmpty() ? 'Sin pasar filtros:getAll' : 'pasando filtros:filter'}");
    return filter.isEmpty()
        ? await repository.getAll()
        : await repository.filter(filter.toJson());
  }

  @override
  GetProductByFieldUseCaseParams? getParams() {
    return parameters;
  }

  @override
  UseCase<EntityModelList<Entity>, GetProductByFieldUseCaseParams> setParams(
      GetProductByFieldUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<Entity>, GetProductByFieldUseCaseParams>
      setParamsFromMap(Map params) {
    parameters = GetProductByFieldUseCaseParams.fromMap(params);
    return this;
  }
}

class GetProductByFieldUseCaseParams extends Parametizable {
  final String id;
  final String idOrder;
  final String name;
  GetProductByFieldUseCaseParams({
    this.id = "",
    this.idOrder = "",
    this.name = "",
  }) : super();

  factory GetProductByFieldUseCaseParams.fromMap(Map json) =>
      GetProductByFieldUseCaseParams(
        id: json["id"] ?? "",
        idOrder: json["idOrder"] ?? "",
        name: json["name"] ?? "",
      );

  bool isEmpty() {
    return id == idOrder && id == name && id == "";
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "idOrder": idOrder,
        "name": name,
      };
}
