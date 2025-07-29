// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/repository/order_detail_repository.dart';

FilterUseCaseOrderDetailParams filterUseCaseOrderDetailParamsFromMap(
        Map<dynamic, dynamic> params) =>
    FilterUseCaseOrderDetailParams.fromMap(params);

class FilterOrderDetailUseCase<OrderDetailModel>
    implements
        UseCase<EntityModelList<OrderDetailModel>,
            FilterUseCaseOrderDetailParams> {
  final OrderDetailRepository<OrderDetailModel> repository;
  FilterUseCaseOrderDetailParams? parameters;

  FilterOrderDetailUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<OrderDetailModel>>> call(
    FilterUseCaseOrderDetailParams? params,
  ) async {
    parameters = params ?? parameters;
    return parameters != null && parameters!.isValid()
        ? await repository.filter(parameters!.toJson())
        : await Future.value(Left(InvalidParamsFailure(
            message:
                "Los parámetros de la búsqueda son vacíos o incorrectos.")));
  }

  Future<Either<Failure, EntityModelList<OrderDetailModel>>> filter() async {
    return call(getParams()!);
  }

  @override
  FilterUseCaseOrderDetailParams? getParams() {
    return parameters = parameters ?? FilterUseCaseOrderDetailParams();
  }

  @override
  UseCase<EntityModelList<OrderDetailModel>, FilterUseCaseOrderDetailParams>
      setParams(FilterUseCaseOrderDetailParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<OrderDetailModel>, FilterUseCaseOrderDetailParams>
      setParamsFromMap(Map params) {
    parameters = FilterUseCaseOrderDetailParams.fromMap(params);
    return this;
  }
}

class FilterUseCaseOrderDetailParams extends Parametizable {
  final String? id;
  final String? idOrder;

  int? start = 1;
  int? limit = 20;

  FilterUseCaseOrderDetailParams({this.id, this.idOrder}) : super();

  factory FilterUseCaseOrderDetailParams.fromMap(
          Map<dynamic, dynamic> params) =>
      FilterUseCaseOrderDetailParams(
        id: params.containsKey("id") ? params["id"] : "",
        idOrder: params.containsKey("idOrder") ? params["idOrder"] : "",
      );

  @override
  bool isValid() {
    //TODO implementar la validación de cada campo del filtro
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "idOrder": idOrder,
      };

  bool _validate<T>(T? value) {
    return value != null;
  }
}
