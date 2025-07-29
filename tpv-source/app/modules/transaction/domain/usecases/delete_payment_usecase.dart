// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/models/payment_model.dart';
import '../repository/payment_repository.dart';

class DeletePaymentUseCase<PaymentModelEntity extends PaymentModel> implements UseCase<PaymentModelEntity, DeleteUseCasePaymentParams> {

  final PaymentRepository<PaymentModelEntity> repository;
  
  late DeleteUseCasePaymentParams? parameters;

  DeletePaymentUseCase(this.repository);

  @override
  Future<Either<Failure, PaymentModelEntity>> call(
    DeleteUseCasePaymentParams? params,
  ) async {
    return await repository.delete((parameters = params)!.id);
  }

  @override
  DeleteUseCasePaymentParams? getParams() {
    return parameters=parameters ?? DeleteUseCasePaymentParams(id:0);
  }

  @override
  UseCase<PaymentModelEntity, DeleteUseCasePaymentParams> setParams(
      DeleteUseCasePaymentParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<PaymentModelEntity, DeleteUseCasePaymentParams> setParamsFromMap(Map params) {
    parameters = DeleteUseCasePaymentParams.fromMap(params);
    return this;
  }

}

DeleteUseCasePaymentParams deleteUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    DeleteUseCasePaymentParams.fromMap(params);

class DeleteUseCasePaymentParams extends Parametizable {

  final int id;
  DeleteUseCasePaymentParams({required this.id}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory DeleteUseCasePaymentParams.fromMap(Map<dynamic, dynamic> params) =>
      DeleteUseCasePaymentParams(
        id: params.containsKey("id") ? params["id"] : 0 
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id
      };
   
}

