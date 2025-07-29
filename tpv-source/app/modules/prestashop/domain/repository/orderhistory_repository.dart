import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';

abstract class OrderHistoryRepository<OrderHistoryModel>
    extends Repository<OrderHistoryModel> {
  @override
  Future<Either<Failure, OrderHistoryModel>> add(dynamic entity);

  @override
  DataSource buildDataSource(String path);

  @override
  Future<Either<Failure, OrderHistoryModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<OrderHistoryModel>>> filter(
      Map<String, dynamic> filters);

  @override
  Future<Either<Failure, OrderHistoryModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<OrderHistoryModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<OrderHistoryModel>>> getBy(Map params);

  Future<Either<Failure, OrderHistoryModel>> getOrderHistory(dynamic id);

  @override
  Future<Either<Failure, EntityModelList<OrderHistoryModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, OrderHistoryModel>> update(
      dynamic entityId, dynamic entity);
}
