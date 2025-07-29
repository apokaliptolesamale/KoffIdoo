import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';

abstract class QrCodeRepository<QrCodeModel> extends Repository<QrCodeModel> {
  @override
  Future<Either<Failure, QrCodeModel>> add(dynamic entity);

  @override
  DataSource buildDataSource(String path);

  @override
  Future<Either<Failure, QrCodeModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<QrCodeModel>>> filter(
      Map<String, dynamic> filters);

  @override
  Future<Either<Failure, QrCodeModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<QrCodeModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<QrCodeModel>>> getBy(Map params);

  Future<Either<Failure, QrCodeModel>> getQrCode(dynamic id);

  @override
  Future<Either<Failure, EntityModelList<QrCodeModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, QrCodeModel>> update(dynamic entityId, dynamic entity);
}
