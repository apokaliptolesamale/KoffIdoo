import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';

abstract class DesignRepository<DesignModel> extends Repository<DesignModel> {
  @override
  Future<Either<Failure, DesignModel>> add(dynamic entity);

  @override
  DataSource buildDataSource(String path);

  @override
  Future<Either<Failure, DesignModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<DesignModel>>> filter(
      Map<String, dynamic> filters);

  @override
  Future<Either<Failure, DesignModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<DesignModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<DesignModel>>> getBy(Map params);

  Future<Either<Failure, DesignModel>> getDesign(dynamic id);

  @override
  Future<Either<Failure, EntityModelList<DesignModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, DesignModel>> update(dynamic entityId, dynamic entity);
}
