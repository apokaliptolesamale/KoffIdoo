import 'package:dartz/dartz.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/repository.dart';

abstract class GiftRepository<GiftModel> extends Repository<GiftModel> {
  Future<Either<Failure, GiftModel>> getGift(dynamic id);

  @override
  Future<Either<Failure, EntityModelList<GiftModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<GiftModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, GiftModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<GiftModel>>> getBy(Map params);

  @override
  Future<Either<Failure, GiftModel>> update(dynamic entityId, dynamic entity);

  @override
  Future<Either<Failure, GiftModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, GiftModel>> add(dynamic entity);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<GiftModel>>> filter(
      Map<String, dynamic> filters);

  @override
  DataSource buildDataSource(String path);
}
