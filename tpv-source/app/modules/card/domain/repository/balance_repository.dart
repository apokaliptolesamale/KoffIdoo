import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';

abstract class BalanceRepository<BalanceModel>
    extends Repository<BalanceModel> {
  @override
  Future<Either<Failure, BalanceModel>> add(dynamic entity);

  @override
  DataSource buildDataSource(String path);

  @override
  Future<Either<Failure, BalanceModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<BalanceModel>>> filter(
      Map<String, dynamic> filters);

  @override
  Future<Either<Failure, BalanceModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<BalanceModel>>> getAll();

  Future<Either<Failure, BalanceModel>> getBalance(dynamic id);

  @override
  Future<Either<Failure, EntityModelList<BalanceModel>>> getBy(Map params);

  @override
  Future<Either<Failure, EntityModelList<BalanceModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, BalanceModel>> update(
      dynamic entityId, dynamic entity);
}
