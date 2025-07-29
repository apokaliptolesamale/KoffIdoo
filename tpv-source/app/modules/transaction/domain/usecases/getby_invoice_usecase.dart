// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';

class GetInvoiceByFieldUseCase<Entity extends EntityModel>
    implements UseCase<EntityModelList<Entity>, GetInvoiceByFieldUseCaseParams> {
  final Repository<Entity> repository;
  late GetInvoiceByFieldUseCaseParams? parameters;
  GetInvoiceByFieldUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<Entity>>> call(
    GetInvoiceByFieldUseCaseParams? params,
  ) async {
    return (params==null && parameters==null)?Left(NulleableFailure(
        message: "Ha ocurrido un error relacionado a los parámetros de la operación.")): await repository.getBy((params??parameters)!.toJson());
  }

  @override
  GetInvoiceByFieldUseCaseParams? getParams() {
    return parameters;
  }

  @override
  UseCase<EntityModelList<Entity>, GetInvoiceByFieldUseCaseParams> setParams(
      GetInvoiceByFieldUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<Entity>, GetInvoiceByFieldUseCaseParams> setParamsFromMap(
      Map params) {
    return this;
  }
}

class GetInvoiceByFieldUseCaseParams extends Parametizable {
  final int id;
  GetInvoiceByFieldUseCaseParams({required this.id}) : super();

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
