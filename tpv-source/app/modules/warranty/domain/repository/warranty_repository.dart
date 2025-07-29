import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';

abstract class WarrantyRepository<WarrantyModel>
    extends Repository<WarrantyModel> {
  @override
  Future<Either<Failure, WarrantyModel>> add(dynamic entity);

  @override
  DataSource buildDataSource(String path);

  @override
  Future<Either<Failure, WarrantyModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<WarrantyModel>>> filter(
      Map<String, dynamic> filters);

  @override
  Future<Either<Failure, WarrantyModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<WarrantyModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<WarrantyModel>>> getBy(Map params);

  Future<Either<Failure, WarrantyModel>> getWarranty(dynamic id);

  @override
  Future<Either<Failure, EntityModelList<WarrantyModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, WarrantyModel>> update(
      dynamic entityId, dynamic entity);
}
