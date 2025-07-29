// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/payment_repository.dart';

class ListPaymentUseCase<PaymentModel> implements UseCase<EntityModelList<PaymentModel>, ListUseCasePaymentParams> {
 
  final PaymentRepository<PaymentModel> repository;
  late ListUseCasePaymentParams? parameters;

  ListPaymentUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<PaymentModel>>> call(
    ListUseCasePaymentParams? params,
  ) async {
    return await repository.getAll();
  }

  Future<Either<Failure, EntityModelList<PaymentModel>>> getAll() async {
    return await call(getParams());
  }

  @override
  ListUseCasePaymentParams? getParams() {
    return parameters=parameters ?? ListUseCasePaymentParams();
  }

  @override
  UseCase<EntityModelList<PaymentModel>, ListUseCasePaymentParams> setParams(
      ListUseCasePaymentParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<PaymentModel>, ListUseCasePaymentParams> setParamsFromMap(Map params) {
    parameters = ListUseCasePaymentParams.fromMap(params);
    return this;
  }
}

ListUseCasePaymentParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListUseCasePaymentParams.fromMap(params);

class ListUseCasePaymentParams extends Parametizable {
  final int? start;
  final int? limit;
  late bool? getAll;

  ListUseCasePaymentParams({
    this.start=-1,
    this.limit=-1,
    this.getAll=false,
  }) : super() {
    if(start==-1||limit==-1) getAll = true;
  }

  @override
  bool isValid() {
    return start! > 0 && start! < limit!;
  }

  factory ListUseCasePaymentParams.fromMap(Map<dynamic, dynamic> params) =>
      ListUseCasePaymentParams(
        start: params.containsKey("start") ? params["start"] : 1,
        limit: params.containsKey("limit") ? params["limit"] : 50,
      );

  @override
  Map<String, dynamic> toJson() => {"start": start ?? 1, "limit": limit ?? 50};
}
