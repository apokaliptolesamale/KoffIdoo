import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';
import '../models/order_model.dart';

abstract class OrderRepository<Model extends OrderModel>
    extends Repository<Model> {
  @override
  Future<Either<Failure, Model>> add(dynamic entity);

  @override
  DataSource buildDataSource(String path);

  @override
  Future<Either<Failure, Model>> delete(dynamic entityId);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<Model>>> filter(
      Map<String, dynamic> filters);

  @override
  Future<Either<Failure, Model>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<Model>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<Model>>> getBy(Map params);

  Future<Either<Failure, Model>> getOrder(dynamic id);

  @override
  Future<Either<Failure, EntityModelList<Model>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, Model>> update(dynamic entityId, dynamic entity);
}
