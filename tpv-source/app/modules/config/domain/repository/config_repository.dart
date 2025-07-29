import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';

abstract class ConfigRepository<ConfigModel> extends Repository<ConfigModel> {
  @override
  Future<Either<Failure, ConfigModel>> add(dynamic entity);

  @override
  DataSource buildDataSource(String path);

  @override
  Future<Either<Failure, ConfigModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<ConfigModel>>> filter(
      Map<String, dynamic> filters);

  @override
  Future<Either<Failure, ConfigModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<ConfigModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<ConfigModel>>> getBy(Map params);

  Future<Either<Failure, ConfigModel>> getConfig(dynamic id);

  @override
  Future<Either<Failure, EntityModelList<ConfigModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, ConfigModel>> update(dynamic entityId, dynamic entity);
}
