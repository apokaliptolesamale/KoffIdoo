// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/payment_repository.dart';

class GetPaymentUseCase<PaymentModel> implements UseCase<PaymentModel, GetUseCasePaymentParams> {

  final PaymentRepository<PaymentModel> repository;
  late GetUseCasePaymentParams? parameters;

  GetPaymentUseCase(this.repository);

  @override
  Future<Either<Failure, PaymentModel>> call(
    GetUseCasePaymentParams? params,
  ) async {
    return await repository.getPayment((parameters = params)!.id);
  }

  @override
  GetUseCasePaymentParams? getParams() {
    return parameters=parameters ?? GetUseCasePaymentParams(id:0);
  }

  @override
  UseCase<PaymentModel, GetUseCasePaymentParams> setParams(
      GetUseCasePaymentParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<PaymentModel, GetUseCasePaymentParams> setParamsFromMap(Map params) {
    parameters = GetUseCasePaymentParams.fromMap(params);
    return this;
  }

}

GetUseCasePaymentParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCasePaymentParams.fromMap(params);

class GetUseCasePaymentParams extends Parametizable {
  
  final int id;
  GetUseCasePaymentParams({required this.id}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory GetUseCasePaymentParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCasePaymentParams(
        id: params.containsKey("id") ? params["id"] : 0 
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id
      };
   
}

