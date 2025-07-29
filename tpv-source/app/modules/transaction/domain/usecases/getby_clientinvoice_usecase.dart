// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';

class GetClientInvoiceByFieldUseCase<Entity extends EntityModel>
    implements UseCase<EntityModelList<Entity>, GetClientInvoiceByFieldUseCaseParams> {
  final Repository<Entity> repository;
  late GetClientInvoiceByFieldUseCaseParams? parameters;
  GetClientInvoiceByFieldUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<Entity>>> call(
    GetClientInvoiceByFieldUseCaseParams? params,
  ) async {
    return (params==null && parameters==null)?Left(NulleableFailure(
        message: "Ha ocurrido un error relacionado a los parámetros de la operación.")): await repository.getBy((params??parameters)!.toJson());
  }

  @override
  GetClientInvoiceByFieldUseCaseParams? getParams() {
    return parameters;
  }

  @override
  UseCase<EntityModelList<Entity>, GetClientInvoiceByFieldUseCaseParams> setParams(
      GetClientInvoiceByFieldUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<Entity>, GetClientInvoiceByFieldUseCaseParams> setParamsFromMap(
      Map params) {
    return this;
  }
}

class GetClientInvoiceByFieldUseCaseParams extends Parametizable {
  final int id;
  GetClientInvoiceByFieldUseCaseParams({required this.id,}) : super();

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
