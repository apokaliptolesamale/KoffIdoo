// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/payment_repository.dart';

class AddPaymentUseCase<PaymentModel> implements UseCase<PaymentModel, AddUseCasePaymentParams> {

  final PaymentRepository<PaymentModel> repository;
  late AddUseCasePaymentParams? parameters;

  AddPaymentUseCase(this.repository);

  @override
  Future<Either<Failure, PaymentModel>> call(
    AddUseCasePaymentParams? params,
  ) async {
    return await repository.add(parameters=params);
  }

  @override
  AddUseCasePaymentParams? getParams() {
    return parameters=parameters ?? AddUseCasePaymentParams(id:0);
  }

  @override
  UseCase<PaymentModel, AddUseCasePaymentParams> setParams(AddUseCasePaymentParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<PaymentModel, AddUseCasePaymentParams> setParamsFromMap(Map params) {
    parameters = AddUseCasePaymentParams.fromMap(params);
    return this;
  }

}

AddUseCasePaymentParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    AddUseCasePaymentParams.fromMap(params);

class AddUseCasePaymentParams extends Parametizable {

  final int id;
  AddUseCasePaymentParams({required this.id}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory AddUseCasePaymentParams.fromMap(Map<dynamic, dynamic> params) =>
      AddUseCasePaymentParams(
        id: params.containsKey("id") ? params["id"] : 0 
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id
      };
   
}

