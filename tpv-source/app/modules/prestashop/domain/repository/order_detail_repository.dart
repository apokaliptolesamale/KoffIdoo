import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';

abstract class OrderDetailRepository<OrderDetailModel>
    extends Repository<OrderDetailModel> {
  @override
  Future<Either<Failure, OrderDetailModel>> add(dynamic entity);

  @override
  DataSource buildDataSource(String path);

  @override
  Future<Either<Failure, OrderDetailModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<OrderDetailModel>>> filter(
      Map<String, dynamic> filters);

  @override
  Future<Either<Failure, OrderDetailModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<OrderDetailModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<OrderDetailModel>>> getBy(Map params);

  Future<Either<Failure, OrderDetailModel>> getOrderDetail(dynamic id);

  @override
  Future<Either<Failure, EntityModelList<OrderDetailModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, OrderDetailModel>> update(
      dynamic entityId, dynamic entity);
}
