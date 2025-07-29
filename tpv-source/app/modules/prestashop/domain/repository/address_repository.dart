import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';

abstract class AddressRepository<AddressModel>
    extends Repository<AddressModel> {
  @override
  Future<Either<Failure, AddressModel>> add(dynamic entity);

  @override
  DataSource buildDataSource(String path);

  @override
  Future<Either<Failure, AddressModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<AddressModel>>> filter(
      Map<String, dynamic> filters);

  @override
  Future<Either<Failure, AddressModel>> get(dynamic entityId);

  Future<Either<Failure, AddressModel>> getAddress(dynamic id);

  @override
  Future<Either<Failure, EntityModelList<AddressModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<AddressModel>>> getBy(Map params);

  @override
  Future<Either<Failure, EntityModelList<AddressModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, AddressModel>> update(
      dynamic entityId, dynamic entity);
}
