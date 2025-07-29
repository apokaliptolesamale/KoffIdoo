import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';

abstract class StatusRepository<StatusModel> extends Repository<StatusModel> {
  @override
  Future<Either<Failure, StatusModel>> add(dynamic entity);

  @override
  DataSource buildDataSource(String path);

  @override
  Future<Either<Failure, StatusModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<StatusModel>>> filter(
      Map<String, dynamic> filters);

  @override
  Future<Either<Failure, StatusModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<StatusModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<StatusModel>>> getBy(Map params);

  Future<Either<Failure, StatusModel>> getStatus(dynamic id);

  @override
  Future<Either<Failure, EntityModelList<StatusModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, StatusModel>> update(dynamic entityId, dynamic entity);
}
