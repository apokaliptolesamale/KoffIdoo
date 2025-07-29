// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/donation_repository.dart';

class ListDonationUseCase<DonationModel> implements UseCase<EntityModelList<DonationModel>, ListUseCaseDonationParams> {
 
  final DonationRepository<DonationModel> repository;
  late ListUseCaseDonationParams? parameters;

  ListDonationUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<DonationModel>>> call(
    ListUseCaseDonationParams? params,
  ) async {
    return await repository.getAll();
  }

  Future<Either<Failure, EntityModelList<DonationModel>>> getAll() async {
    return await call(getParams());
  }

  @override
  ListUseCaseDonationParams? getParams() {
    return parameters=parameters ?? ListUseCaseDonationParams();
  }

  @override
  UseCase<EntityModelList<DonationModel>, ListUseCaseDonationParams> setParams(
      ListUseCaseDonationParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<DonationModel>, ListUseCaseDonationParams> setParamsFromMap(Map params) {
    parameters = ListUseCaseDonationParams.fromMap(params);
    return this;
  }
}

ListUseCaseDonationParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListUseCaseDonationParams.fromMap(params);

class ListUseCaseDonationParams extends Parametizable {
  final int? start;
  final int? limit;
  late bool? getAll;

  ListUseCaseDonationParams({
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

  factory ListUseCaseDonationParams.fromMap(Map<dynamic, dynamic> params) =>
      ListUseCaseDonationParams(
        start: params.containsKey("start") ? params["start"] : 1,
        limit: params.containsKey("limit") ? params["limit"] : 50,
      );

  @override
  Map<String, dynamic> toJson() => {"start": start ?? 1, "limit": limit ?? 50};
}
