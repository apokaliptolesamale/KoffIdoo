import 'package:dartz/dartz.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/repository.dart';



abstract class CategoryGiftRepository<CategoryGiftModel> extends Repository<CategoryGiftModel> {

  Future<Either<Failure, CategoryGiftModel>> getGift(dynamic id);

  @override
  Future<Either<Failure, EntityModelList<CategoryGiftModel>>> getAll();

  
  @override
  Future<Either<Failure, EntityModelList<CategoryGiftModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, CategoryGiftModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<CategoryGiftModel>>> getBy(Map params);

  @override
  Future<Either<Failure, CategoryGiftModel>> update(dynamic entityId,dynamic entity);

  @override
  Future<Either<Failure, CategoryGiftModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, CategoryGiftModel>> add(dynamic entity);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<CategoryGiftModel>>> filter(Map<String,dynamic> filters);

  @override
  DataSource buildDataSource(String path);

}
