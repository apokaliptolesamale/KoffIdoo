// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/models/donation_model.dart';
import '../repository/donation_repository.dart';

class DeleteDonationUseCase<DonationModelEntity extends DonationModel> implements UseCase<DonationModelEntity, DeleteUseCaseDonationParams> {

  final DonationRepository<DonationModelEntity> repository;
  
  late DeleteUseCaseDonationParams? parameters;

  DeleteDonationUseCase(this.repository);

  @override
  Future<Either<Failure, DonationModelEntity>> call(
    DeleteUseCaseDonationParams? params,
  ) async {
    return await repository.delete((parameters = params)!.id);
  }

  @override
  DeleteUseCaseDonationParams? getParams() {
    return parameters=parameters ?? DeleteUseCaseDonationParams(id:0);
  }

  @override
  UseCase<DonationModelEntity, DeleteUseCaseDonationParams> setParams(
      DeleteUseCaseDonationParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<DonationModelEntity, DeleteUseCaseDonationParams> setParamsFromMap(Map params) {
    parameters = DeleteUseCaseDonationParams.fromMap(params);
    return this;
  }

}

DeleteUseCaseDonationParams deleteUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    DeleteUseCaseDonationParams.fromMap(params);

class DeleteUseCaseDonationParams extends Parametizable {

  final int id;
  DeleteUseCaseDonationParams({required this.id}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory DeleteUseCaseDonationParams.fromMap(Map<dynamic, dynamic> params) =>
      DeleteUseCaseDonationParams(
        id: params.containsKey("id") ? params["id"] : 0 
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id
      };
   
}

