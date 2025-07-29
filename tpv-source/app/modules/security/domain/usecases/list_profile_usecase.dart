// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../../app/modules/security/data/repositories/profile_repository_impl.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';

class ListProfileUseCase<ProfileModel>
    implements
        UseCase<EntityModelList<ProfileModel>,
            ListProfileUseCaseUseCaseUserParams> {
  final ProfileRepositoryImpl<ProfileModel> repository;
  late ListProfileUseCaseUseCaseUserParams? parameters;
  ListProfileUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<ProfileModel>>> call(
    ListProfileUseCaseUseCaseUserParams? params,
  ) async {
    parameters = params;
    return await repository.getAll();
  }

  Future<Either<Failure, EntityModelList<ProfileModel>>> getAll() async {
    return call(getParams());
  }

  @override
  ListProfileUseCaseUseCaseUserParams? getParams() {
    return parameters;
  }

  @override
  UseCase<EntityModelList<ProfileModel>, ListProfileUseCaseUseCaseUserParams>
      setParams(ListProfileUseCaseUseCaseUserParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<ProfileModel>, ListProfileUseCaseUseCaseUserParams>
      setParamsFromMap(Map params) {
    return this;
  }
}

class ListProfileUseCaseUseCaseUserParams extends Parametizable {
  final String userName;
  ListProfileUseCaseUseCaseUserParams({
    required this.userName,
  }) : super();
}
