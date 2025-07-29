import 'package:dartz/dartz.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/repository.dart';

abstract class TpvRepository<TpvModel> extends Repository<TpvModel> {
  Future<Either<Failure, TpvModel>> getTpv(dynamic id);

  @override
  Future<Either<Failure, EntityModelList<TpvModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<TpvModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, TpvModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<TpvModel>>> getBy(Map params);

  @override
  Future<Either<Failure, TpvModel>> update(dynamic entityId, dynamic entity);

  @override
  Future<Either<Failure, TpvModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, TpvModel>> add(dynamic entity);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<TpvModel>>> filter(
      Map<String, dynamic> filters);

  @override
  DataSource buildDataSource(String path);
}
