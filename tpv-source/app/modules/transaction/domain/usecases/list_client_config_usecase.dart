// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '/app/modules/transaction/domain/models/client_service_model.dart';
import '/app/modules/transaction/domain/models/clientinvoice_model.dart';
import '/app/modules/transaction/clientinvoice_exporting.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';

class ListClientConfigUseCase<T>
    implements
        UseCase<EntityModelList<ClientServiceModel>,
            ListClientConfigUseCaseParams> {
  final ClientInvoiceRepository<ClientInvoiceModel> repository;
  late ListClientConfigUseCaseParams? parameters;
  ListClientConfigUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<ClientServiceModel>>> call(
    ListClientConfigUseCaseParams? params,
  ) async {
    /* if(parameters!.limit! > 10 && parameters!.offset! > 0 ){
      return await repository.paginate(0,10,parameters!.toJson());
    }*/
    return await repository.listClientConfig(params!.toJson());
  }

  Future<Either<Failure, EntityModelList<ClientServiceModel>>>
      listConfigService() async {
    return await call(getParams()!);
  }

  @override
  ListClientConfigUseCaseParams? getParams() {
    return parameters = parameters ?? ListClientConfigUseCaseParams();
  }

  @override
  UseCase<EntityModelList<ClientServiceModel>, ListClientConfigUseCaseParams>
      setParams(ListClientConfigUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<ClientServiceModel>, ListClientConfigUseCaseParams>
      setParamsFromMap(Map params) {
    parameters = ListClientConfigUseCaseParams.fromMap(params);
    return this;
  }
}

ListClientConfigUseCaseParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListClientConfigUseCaseParams.fromMap(params);

class ListClientConfigUseCaseParams extends Parametizable {
  final String? offset;
  final String? limit;
  final String? servicCode;

  ListClientConfigUseCaseParams({this.offset, this.limit, this.servicCode})
      : super() {
    offset;
    limit;
  }

  @override
  bool isValid() {
    return true;
  }

  factory ListClientConfigUseCaseParams.fromMap(Map<dynamic, dynamic> params) =>
      ListClientConfigUseCaseParams(
          offset: params.containsKey("offset") ? params["offset"] : "0",
          limit: params.containsKey("limit") ? params["limit"] : "10",
          servicCode: params.containsKey("service_code")
              ? params["service_code"]
              : null);

  @override
  Map<String, dynamic> toJson() =>
      {"offset": offset, "limit": limit, "service_code": servicCode};
}
