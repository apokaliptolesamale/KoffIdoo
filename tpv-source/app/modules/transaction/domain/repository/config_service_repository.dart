import 'package:dartz/dartz.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/repository.dart';

abstract class ClientServiceRepository<ClientServiceModel>
    extends Repository<ClientServiceModel> {
  @override
  Future<Either<Failure, EntityModelList<ClientServiceModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<ClientServiceModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, ClientServiceModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<ClientServiceModel>>> getBy(
      Map params);

  @override
  Future<Either<Failure, ClientServiceModel>> update(
      dynamic entityId, dynamic entity);

  @override
  Future<Either<Failure, ClientServiceModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, ClientServiceModel>> add(dynamic entity);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<ClientServiceModel>>> filter(
      Map<String, dynamic> filters);

  @override
  DataSource buildDataSource(String path);

  Future<Either<Failure, EntityModelList<ClientServiceModel>>> getClientIds(
      Map<String, dynamic> params);

  Future<Either<Failure, ClientServiceModel>> addClientId(dynamic entity);

  Future<Either<Failure, EntityModelList<ClientServiceModel>>> getClientId(
      Map<String, dynamic> params);
}
