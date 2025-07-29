// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../models/donation_model.dart';
import '../repository/donation_repository.dart';

class AddDonationUseCase<DonationModel> implements UseCase<DonationModel, AddUseCaseDonationParams> {

  final DonationRepository<DonationModel> repository;
  late AddUseCaseDonationParams? parameters;

  AddDonationUseCase(this.repository);

  @override
  Future<Either<Failure, DonationModel>> call(
    AddUseCaseDonationParams? params,
  ) async {
    return params != null
        ? await repository.add((parameters = params).model)
        : Left(NulleableFailure(message: "Sin parámetros"));
  }

  @override
  AddUseCaseDonationParams? getParams() {
    return parameters=parameters ?? AddUseCaseDonationParams(model:CreateDonationModel(fundingSourceUuid: '', description: '', donationUuid: '', amount: '', currency: '', paymentPassword: '', fingerprint: ''));
  }

  @override
  UseCase<DonationModel, AddUseCaseDonationParams> setParams(AddUseCaseDonationParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<DonationModel, AddUseCaseDonationParams> setParamsFromMap(Map params) {
    parameters = AddUseCaseDonationParams.fromMap(params);
    return this;
  }

}

AddUseCaseDonationParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    AddUseCaseDonationParams.fromMap(params);

class AddUseCaseDonationParams extends Parametizable {

  final CreateDonationModel model;
  AddUseCaseDonationParams({required this.model}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory AddUseCaseDonationParams.fromMap(Map<dynamic, dynamic> params) =>
      AddUseCaseDonationParams(
        model: params.containsKey("id") ? params["id"] : CreateDonationModel(fundingSourceUuid: '', description: '', donationUuid: '', amount: '', currency: '', paymentPassword: '', fingerprint: '') 
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id
      };
   
}

