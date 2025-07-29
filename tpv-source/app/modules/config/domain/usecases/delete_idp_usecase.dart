// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/models/idp_model.dart';
import '../repository/idp_repository.dart';

class DeleteIdpUseCase<IdpModelEntity extends IdpModel> implements UseCase<IdpModelEntity, DeleteUseCaseIdpParams> {

  final IdpRepository<IdpModelEntity> repository;
  
  late DeleteUseCaseIdpParams? parameters;

  DeleteIdpUseCase(this.repository);

  @override
  Future<Either<Failure, IdpModelEntity>> call(
    DeleteUseCaseIdpParams? params,
  ) async {
    return (params==null && parameters==null)?Left(NulleableFailure(
        message: "Ha ocurrido un error relacionado a los parámetros de la operación.")): await repository.delete((params??parameters)!.id);
  }

  @override
  DeleteUseCaseIdpParams? getParams() {
    return parameters=parameters ?? DeleteUseCaseIdpParams(id:0);
  }

  @override
  UseCase<IdpModelEntity, DeleteUseCaseIdpParams> setParams(
      DeleteUseCaseIdpParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<IdpModelEntity, DeleteUseCaseIdpParams> setParamsFromMap(Map params) {
    parameters = DeleteUseCaseIdpParams.fromMap(params);
    return this;
  }

}

DeleteUseCaseIdpParams deleteUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    DeleteUseCaseIdpParams.fromMap(params);

class DeleteUseCaseIdpParams extends Parametizable {

  final int id;
  DeleteUseCaseIdpParams({required this.id}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory DeleteUseCaseIdpParams.fromMap(Map<dynamic, dynamic> params) =>
      DeleteUseCaseIdpParams(
        id: params.containsKey("id") ? params["id"] : 0 
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id
      };
   
}

