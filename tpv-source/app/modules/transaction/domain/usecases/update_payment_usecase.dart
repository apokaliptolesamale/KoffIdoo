// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../models/payment_model.dart';
import '../repository/payment_repository.dart';

class UpdatePaymentUseCase<PaymentModelEntity extends PaymentModel>
    implements UseCase<PaymentModelEntity, UpdateUseCasePaymentParams> {
  final PaymentRepository<PaymentModelEntity> repository;
  late UpdateUseCasePaymentParams? parameters;
  UpdatePaymentUseCase(this.repository);

  @override
  Future<Either<Failure, PaymentModelEntity>> call(
    UpdateUseCasePaymentParams? params,
  ) async {
    return await repository.update((parameters = params)!.id, params!.entity);
  }

  @override
  UpdateUseCasePaymentParams? getParams() {
    return parameters = parameters ??
        UpdateUseCasePaymentParams(
            id: 0, entity: PaymentModel(transactionUuId: "1"));
  }

  @override
  UseCase<PaymentModelEntity, UpdateUseCasePaymentParams> setParams(
      UpdateUseCasePaymentParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<PaymentModelEntity, UpdateUseCasePaymentParams> setParamsFromMap(
      Map params) {
    return this;
  }
}

class UpdateUseCasePaymentParams extends Parametizable {
  final dynamic id;
  final PaymentModel entity;
  UpdateUseCasePaymentParams({required this.id, required this.entity})
      : super();
}
