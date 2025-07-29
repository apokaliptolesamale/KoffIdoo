// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart'; 
import '../repository/idp_repository.dart';

class AddIdpUseCase<IdpModel> implements UseCase<IdpModel, AddUseCaseIdpParams> {

  final IdpRepository<IdpModel> repository;
  late AddUseCaseIdpParams? parameters;

  AddIdpUseCase(this.repository);

  @override
  Future<Either<Failure, IdpModel>> call(
    AddUseCaseIdpParams? params,
  ) async {
    return (params==null && parameters==null)?Left(NulleableFailure(
        message: "Ha ocurrido un error relacionado a los parámetros de la operación.")):await repository.add(params??parameters);
  }

  @override
  AddUseCaseIdpParams? getParams() {
    return parameters=parameters ?? AddUseCaseIdpParams(id:0);
  }

  @override
  UseCase<IdpModel, AddUseCaseIdpParams> setParams(AddUseCaseIdpParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<IdpModel, AddUseCaseIdpParams> setParamsFromMap(Map params) {
    parameters = AddUseCaseIdpParams.fromMap(params);
    return this;
  }

}

AddUseCaseIdpParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    AddUseCaseIdpParams.fromMap(params);

class AddUseCaseIdpParams extends Parametizable {

  final int id;
  AddUseCaseIdpParams({required this.id}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory AddUseCaseIdpParams.fromMap(Map<dynamic, dynamic> params) =>
      AddUseCaseIdpParams(
        id: params.containsKey("id") ? params["id"] : 0 
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id
      };
   
}

