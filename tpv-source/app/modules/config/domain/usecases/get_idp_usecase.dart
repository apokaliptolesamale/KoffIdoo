// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart'; 
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/idp_repository.dart';

class GetIdpUseCase<IdpModel> implements UseCase<IdpModel, GetUseCaseIdpParams> {

  final IdpRepository<IdpModel> repository;
  late GetUseCaseIdpParams? parameters;

  GetIdpUseCase(this.repository);

  @override
  Future<Either<Failure, IdpModel>> call(
    GetUseCaseIdpParams? params,
  ) async {
    return (params==null && parameters==null)?Left(NulleableFailure(
        message: "Ha ocurrido un error relacionado a los parámetros de la operación.")): await repository.getIdp((params??parameters)!.id);
  }

  @override
  GetUseCaseIdpParams? getParams() {
    return parameters=parameters ?? GetUseCaseIdpParams(id:0);
  }

  @override
  UseCase<IdpModel, GetUseCaseIdpParams> setParams(
      GetUseCaseIdpParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<IdpModel, GetUseCaseIdpParams> setParamsFromMap(Map params) {
    parameters = GetUseCaseIdpParams.fromMap(params);
    return this;
  }

}

GetUseCaseIdpParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseIdpParams.fromMap(params);

class GetUseCaseIdpParams extends Parametizable {
  
  final int id;
  GetUseCaseIdpParams({required this.id}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory GetUseCaseIdpParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCaseIdpParams(
        id: params.containsKey("id") ? params["id"] : 0 
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id
      };
   
}

