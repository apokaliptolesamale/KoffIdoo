import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';

abstract class ProductRepository<ProductModel>
    extends Repository<ProductModel> {
  @override
  Future<Either<Failure, ProductModel>> add(dynamic entity);

  @override
  DataSource buildDataSource(String path);

  @override
  Future<Either<Failure, ProductModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<ProductModel>>> filter(
      Map<String, dynamic> filters);

  @override
  Future<Either<Failure, ProductModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<ProductModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<ProductModel>>> getBy(Map params);

  Future<Either<Failure, ProductModel>> getProduct(dynamic id);

  @override
  Future<Either<Failure, EntityModelList<ProductModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, ProductModel>> update(
      dynamic entityId, dynamic entity);
}
