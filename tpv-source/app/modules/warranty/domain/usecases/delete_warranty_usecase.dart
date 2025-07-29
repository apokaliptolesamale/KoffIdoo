// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../../app/modules/warranty/domain/models/warranty_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/warranty_repository.dart';

DeleteUseCaseWarrantyParams deleteUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    DeleteUseCaseWarrantyParams.fromMap(params);

class DeleteUseCaseWarrantyParams extends Parametizable {
  final int id;
  DeleteUseCaseWarrantyParams({required this.id}) : super();

  factory DeleteUseCaseWarrantyParams.fromMap(Map<dynamic, dynamic> params) =>
      DeleteUseCaseWarrantyParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}

class DeleteWarrantyUseCase<WarrantyModelEntity extends WarrantyModel>
    implements UseCase<WarrantyModelEntity, DeleteUseCaseWarrantyParams> {
  final WarrantyRepository<WarrantyModelEntity> repository;

  late DeleteUseCaseWarrantyParams? parameters;

  DeleteWarrantyUseCase(this.repository);

  @override
  Future<Either<Failure, WarrantyModelEntity>> call(
    DeleteUseCaseWarrantyParams? params,
  ) async {
    return await repository.delete((parameters = params)!.id);
  }

  @override
  DeleteUseCaseWarrantyParams? getParams() {
    return parameters = parameters ?? DeleteUseCaseWarrantyParams(id: 0);
  }

  @override
  UseCase<WarrantyModelEntity, DeleteUseCaseWarrantyParams> setParams(
      DeleteUseCaseWarrantyParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<WarrantyModelEntity, DeleteUseCaseWarrantyParams> setParamsFromMap(
      Map params) {
    parameters = DeleteUseCaseWarrantyParams.fromMap(params);
    return this;
  }
}
