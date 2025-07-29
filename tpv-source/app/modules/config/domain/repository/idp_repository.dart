import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';

abstract class IdpRepository<IdpModel> extends Repository<IdpModel> {
  Future<Either<Failure, IdpModel>> getIdp(dynamic id);

  @override
  Future<Either<Failure, EntityModelList<IdpModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<IdpModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, IdpModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<IdpModel>>> getBy(Map params);

  @override
  Future<Either<Failure, IdpModel>> update(dynamic entityId, dynamic entity);

  @override
  Future<Either<Failure, IdpModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, IdpModel>> add(dynamic entity);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<IdpModel>>> filter(
      Map<String, dynamic> filters);

  @override
  DataSource buildDataSource(String path);
}
