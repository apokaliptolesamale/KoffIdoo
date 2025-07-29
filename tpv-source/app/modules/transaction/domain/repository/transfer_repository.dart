import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';

abstract class TransferRepository<TransferModel>
    extends Repository<TransferModel> {
  @override
  Future<Either<Failure, TransferModel>> add(dynamic entity);
  @override
  DataSource buildDataSource(String path);

  @override
  Future<Either<Failure, TransferModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<TransferModel>>> filter(
      Map<String, dynamic> filters);

  @override
  Future<Either<Failure, TransferModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<TransferModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<TransferModel>>> getBy(Map params);

  Future<Either<Failure, TransferModel>> getTransfer(dynamic id);

  @override
  Future<Either<Failure, EntityModelList<TransferModel>>> paginate(
      int start, int limit, Map params);

  Future<Either<Failure, TransferModel>> transferToAccount(
      dynamic id, dynamic entity);

  Future<Either<Failure, TransferModel>> transferToCard(
      dynamic id, dynamic entity);

  @override
  Future<Either<Failure, TransferModel>> update(
      dynamic entityId, dynamic entity);
}
