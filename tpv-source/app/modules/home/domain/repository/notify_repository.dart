import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';

abstract class NotifyRepository<NotifyModel> extends Repository<NotifyModel> {
  @override
  Future<Either<Failure, NotifyModel>> add(dynamic entity);

  @override
  DataSource buildDataSource(String path);

  @override
  Future<Either<Failure, NotifyModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<NotifyModel>>> filter(
      Map<String, dynamic> filters);

  @override
  Future<Either<Failure, NotifyModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<NotifyModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<NotifyModel>>> getBy(Map params);

  Future<Either<Failure, NotifyModel>> getNotify(dynamic id);

  @override
  Future<Either<Failure, EntityModelList<NotifyModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, NotifyModel>> update(dynamic entityId, dynamic entity);
}
