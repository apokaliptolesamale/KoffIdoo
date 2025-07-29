import 'package:dartz/dartz.dart';

import '../../core/config/errors/errors.dart';
import 'data_source.dart';
import 'entity_model.dart';

abstract class Repository<Entity> {
  Future<Either<Failure, Entity>> add(Entity entity);

  DataSource buildDataSource(String path);

  Future<Either<Failure, Entity>> delete(dynamic entityId);

  Future<Either<Failure, bool>> exists(dynamic entityId);

  Future<Either<Failure, EntityModelList<Entity>>> filter(
      Map<String, dynamic> filters);

  Future<Either<Failure, Entity>> get(dynamic entityId);

  Future<Either<Failure, EntityModelList<Entity>>> getAll();

  Future<Either<Failure, EntityModelList<Entity>>> getBy(Map params);

  Either<Local, Remote> getDataSourcePath<Local, Remote>(String path);

  bool isRemote(String path);

  Future<Either<Failure, EntityModelList<Entity>>> paginate(
      int start, int limit, Map params);

  Future<Either<Failure, Entity>> update(dynamic entityId, Entity entity);
}
