import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';

abstract class OperationRepository<OperationModel>
    extends Repository<OperationModel> {
  @override
  Future<Either<Failure, OperationModel>> add(dynamic entity);

  @override
  DataSource buildDataSource(String path);

  @override
  Future<Either<Failure, OperationModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<OperationModel>>> filter(
      Map<String, dynamic> filters);

  @override
  Future<Either<Failure, OperationModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<OperationModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<OperationModel>>> getBy(Map params);

  Future<Either<Failure, OperationModel>> getOperation(dynamic id);

  @override
  Future<Either<Failure, EntityModelList<OperationModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, OperationModel>> update(
      dynamic entityId, dynamic entity);
}
