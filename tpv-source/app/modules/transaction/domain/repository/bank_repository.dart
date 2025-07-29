import 'package:dartz/dartz.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/repository.dart';

abstract class BankRepository<BankModel> extends Repository<BankModel> {
  Future<Either<Failure, BankModel>> getBank(dynamic id);

  @override
  Future<Either<Failure, EntityModelList<BankModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<BankModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, BankModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<BankModel>>> getBy(Map params);

  @override
  Future<Either<Failure, BankModel>> update(dynamic entityId, dynamic entity);

  @override
  Future<Either<Failure, BankModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, BankModel>> add(dynamic entity);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<BankModel>>> filter(
      Map<String, dynamic> filters);

  @override
  DataSource buildDataSource(String path);
}
