import 'package:dartz/dartz.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/repository.dart';



abstract class CardGiftRepository<CardGiftModel> extends Repository<CardGiftModel> {

  Future<Either<Failure, CardGiftModel>> getGift(dynamic id);

  @override
  Future<Either<Failure, EntityModelList<CardGiftModel>>> getAll();

  
  @override
  Future<Either<Failure, EntityModelList<CardGiftModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, CardGiftModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<CardGiftModel>>> getBy(Map params);

  @override
  Future<Either<Failure, CardGiftModel>> update(dynamic entityId,dynamic entity);

  @override
  Future<Either<Failure, CardGiftModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, CardGiftModel>> add(dynamic entity);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<CardGiftModel>>> filter(Map<String,dynamic> filters);

  @override
  DataSource buildDataSource(String path);

}
