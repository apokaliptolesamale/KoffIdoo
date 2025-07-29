import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';

abstract class PrestaShopRepository<PrestaShopModel>
    extends Repository<PrestaShopModel> {
  @override
  Future<Either<Failure, PrestaShopModel>> add(dynamic entity);

  @override
  DataSource buildDataSource(String path);

  @override
  Future<Either<Failure, PrestaShopModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<PrestaShopModel>>> filter(
      Map<String, dynamic> filters);

  @override
  Future<Either<Failure, PrestaShopModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<PrestaShopModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<PrestaShopModel>>> getBy(Map params);

  Future<Either<Failure, PrestaShopModel>> getPrestaShop(dynamic id);

  @override
  Future<Either<Failure, EntityModelList<PrestaShopModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, PrestaShopModel>> update(
      dynamic entityId, dynamic entity);
}
