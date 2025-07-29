// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../models/payment_model.dart';
import '/app/modules/transaction/clientinvoice_exporting.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';

class ListClientIdUseCase<ClientInvoiceModel> implements UseCase<EntityModelList<ClientInvoiceModel>, ListClientIdUseCaseParams> {
 
  final ClientInvoiceRepository<ClientInvoiceModel> repository;
  late ListClientIdUseCaseParams? parameters;
  ListClientIdUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<ClientInvoiceModel>>> call(
    ListClientIdUseCaseParams? params,
  ) async {
    if(parameters!.limit! > 10 && parameters!.offset! > 0 ){
      return await repository.paginate(0,10,parameters!.toJson());
    }else{
    return await repository.getAll();
    }
  }

  Future<Either<Failure, EntityModelList<ClientInvoiceModel>>> getAll() async {
    return await call(null);
  }


  @override
  ListClientIdUseCaseParams? getParams() {
    return parameters=  ListClientIdUseCaseParams();
  }

  @override
  UseCase<EntityModelList<ClientInvoiceModel>, ListClientIdUseCaseParams> setParams(
      ListClientIdUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<ClientInvoiceModel>, ListClientIdUseCaseParams> setParamsFromMap(Map params) {
    parameters = ListClientIdUseCaseParams.fromMap(params);
    return this;
  }
  
}

ListClientIdUseCaseParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListClientIdUseCaseParams.fromMap(params);

class ListClientIdUseCaseParams extends Parametizable {
  final int? offset;
  final int? limit;
  final int? servicCode;


  ListClientIdUseCaseParams({
    this.offset= 0,
    this.limit=10,
    this.servicCode = 2222

  }) : super() {
     offset;
     limit;
  }

  @override
  bool isValid() {
    return true;
  }

  factory ListClientIdUseCaseParams.fromMap(Map<dynamic, dynamic> params) =>
      ListClientIdUseCaseParams(
        offset: params.containsKey("offset") ? params["offset"] : 0,
        limit: params.containsKey("limit") ? params["limit"] : 10,
        servicCode: params.containsKey("serviceCode") ? params["serviceCode"]: ServicesPayment.byName("Electricidad")
      );

  @override
  Map<String, dynamic> toJson() => {
    "offset": offset ?? 0,
    "limit": limit ?? 10,
    "service_code": servicCode ?? ServicesPayment.byName("Electricidad")};
}