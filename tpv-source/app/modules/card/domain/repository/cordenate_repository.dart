import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';

abstract class CordenateRepository<CordenateModel>
    extends Repository<CordenateModel> {
  @override
  Future<Either<Failure, CordenateModel>> add(dynamic entity);

  @override
  DataSource buildDataSource(String path);

  @override
  Future<Either<Failure, CordenateModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<CordenateModel>>> filter(
      Map<String, dynamic> filters);

  @override
  Future<Either<Failure, CordenateModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<CordenateModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<CordenateModel>>> getBy(Map params);

  Future<Either<Failure, CordenateModel>> getCordenate();

  @override
  Future<Either<Failure, EntityModelList<CordenateModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, CordenateModel>> update(
      dynamic entityId, dynamic entity);
}
