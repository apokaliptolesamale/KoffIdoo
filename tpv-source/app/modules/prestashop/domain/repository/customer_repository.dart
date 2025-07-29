import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';

abstract class CustomerRepository<CustomerModel>
    extends Repository<CustomerModel> {
  @override
  Future<Either<Failure, CustomerModel>> add(dynamic entity);

  @override
  DataSource buildDataSource(String path);

  @override
  Future<Either<Failure, CustomerModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<CustomerModel>>> filter(
      Map<String, dynamic> filters);

  @override
  Future<Either<Failure, CustomerModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<CustomerModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<CustomerModel>>> getBy(Map params);

  Future<Either<Failure, CustomerModel>> getCustomer(dynamic id);

  @override
  Future<Either<Failure, EntityModelList<CustomerModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, CustomerModel>> update(
      dynamic entityId, dynamic entity);
}
