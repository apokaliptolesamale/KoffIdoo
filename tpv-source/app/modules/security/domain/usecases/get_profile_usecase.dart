// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../../app/modules/security/data/repositories/profile_repository_impl.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';

class GetProfileUseCase<ProfileModel>
    implements UseCase<ProfileModel, GetProfileUseCaseUseCaseUserParams> {
  final ProfileRepositoryImpl<ProfileModel> repository;
  late GetProfileUseCaseUseCaseUserParams? parameters;

  GetProfileUseCase(this.repository);

  @override
  Future<Either<Failure, ProfileModel>> call(
    GetProfileUseCaseUseCaseUserParams? params,
  ) async {
    parameters = params;
    return await repository.getProfile(params != null ? params.userName : "");
  }

  @override
  GetProfileUseCaseUseCaseUserParams? getParams() {
    return parameters;
  }

  Future<Either<Failure, ProfileModel>> getProfile() {
    return call(getParams());
  }

  @override
  UseCase<ProfileModel, GetProfileUseCaseUseCaseUserParams> setParams(
      GetProfileUseCaseUseCaseUserParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<ProfileModel, GetProfileUseCaseUseCaseUserParams> setParamsFromMap(
      Map params) {
    return this;
  }
}

class GetProfileUseCaseUseCaseUserParams extends Parametizable {
  final String userName;
  GetProfileUseCaseUseCaseUserParams({
    required this.userName,
  }) : super();
}
