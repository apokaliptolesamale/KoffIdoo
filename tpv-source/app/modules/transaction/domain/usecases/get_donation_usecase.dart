// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/donation_repository.dart';

class GetDonationUseCase<DonationModel> implements UseCase<DonationModel, GetUseCaseDonationParams> {

  final DonationRepository<DonationModel> repository;
  late GetUseCaseDonationParams? parameters;

  GetDonationUseCase(this.repository);

  @override
  Future<Either<Failure, DonationModel>> call(
    GetUseCaseDonationParams? params,
  ) async {
    return await repository.getDonation((parameters = params)!.id);
  }

  @override
  GetUseCaseDonationParams? getParams() {
    return parameters=parameters ?? GetUseCaseDonationParams(id:0);
  }

  @override
  UseCase<DonationModel, GetUseCaseDonationParams> setParams(
      GetUseCaseDonationParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<DonationModel, GetUseCaseDonationParams> setParamsFromMap(Map params) {
    parameters = GetUseCaseDonationParams.fromMap(params);
    return this;
  }

}

GetUseCaseDonationParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseDonationParams.fromMap(params);

class GetUseCaseDonationParams extends Parametizable {
  
  final int id;
  GetUseCaseDonationParams({required this.id}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory GetUseCaseDonationParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCaseDonationParams(
        id: params.containsKey("id") ? params["id"] : 0 
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id
      };
   
}

