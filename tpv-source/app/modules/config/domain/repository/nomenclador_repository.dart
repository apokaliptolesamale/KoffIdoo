import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';

abstract class NomencladorRepository<NomencladorModel>
    extends Repository<NomencladorModel> {
  @override
  Future<Either<Failure, NomencladorModel>> add(dynamic entity);

  @override
  DataSource buildDataSource(String path);

  @override
  Future<Either<Failure, NomencladorModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<NomencladorModel>>> filter(
      Map<String, dynamic> filters);

  @override
  Future<Either<Failure, NomencladorModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<NomencladorModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<NomencladorModel>>> getBy(Map params);

  Future<Either<Failure, EntityModelList<NomencladorModel>>>
      getComercialUnits();

  Future<Either<Failure, NomencladorModel>> getNomenclador(dynamic id);

  Future<Either<Failure, EntityModelList<NomencladorModel>>>
      getNomencladoresByClientId(String clientId);
  Future<Either<Failure, EntityModelList<NomencladorModel>>>
      getPaymentTypesFromAssets();

  Future<Either<Failure, EntityModelList<NomencladorModel>>>
      getProvinciasFromAssets();

  Future<Either<Failure, EntityModelList<NomencladorModel>>>
      getTrdUnitsFromAssets();

  @override
  Future<Either<Failure, EntityModelList<NomencladorModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, NomencladorModel>> update(
      dynamic entityId, dynamic entity);
}
