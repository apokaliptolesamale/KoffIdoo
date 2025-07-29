// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../../app/modules/security/data/repositories/profile_repository_impl.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';

class FilterProfileUseCase<ProfileModel>
    implements
        UseCase<EntityModelList<ProfileModel>,
            FilterProfileUseCaseUseCaseUserParams> {
  final ProfileRepositoryImpl<ProfileModel> repository;
  late FilterProfileUseCaseUseCaseUserParams? parameters;
  FilterProfileUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<ProfileModel>>> call(
    FilterProfileUseCaseUseCaseUserParams? params,
  ) async {
    parameters = params;
    return await repository
        .filter(parameters != null ? parameters!.toJson() : {});
  }

  Future<Either<Failure, EntityModelList<ProfileModel>>> filter() {
    return call(getParams());
  }

  @override
  FilterProfileUseCaseUseCaseUserParams? getParams() {
    return parameters;
  }

  @override
  UseCase<EntityModelList<ProfileModel>, FilterProfileUseCaseUseCaseUserParams>
      setParams(FilterProfileUseCaseUseCaseUserParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<ProfileModel>, FilterProfileUseCaseUseCaseUserParams>
      setParamsFromMap(Map params) {
    return this;
  }
}

class FilterProfileUseCaseUseCaseUserParams extends Parametizable {
  final String userName;
  FilterProfileUseCaseUseCaseUserParams({
    required this.userName,
  }) : super();
}
