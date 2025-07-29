import 'package:dartz/dartz.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/repository.dart';

abstract class TransactionRepository<TransactionModel>
    extends Repository<TransactionModel> {
  Future<Either<Failure, TransactionModel>> getTransaction(dynamic id);

  @override
  Future<Either<Failure, EntityModelList<TransactionModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<TransactionModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, TransactionModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<TransactionModel>>> getBy(Map params);

  @override
  Future<Either<Failure, TransactionModel>> update(
      dynamic entityId, dynamic entity);

  @override
  Future<Either<Failure, TransactionModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, TransactionModel>> add(dynamic entity);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<TransactionModel>>> filter(
      Map<String, dynamic> filters);

  @override
  DataSource buildDataSource(String path);
}
