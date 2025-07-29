import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';
import '../models/destinatario_model.dart';

abstract class AccountRepository<AccountModel>
    extends Repository<AccountModel> {
  @override
  Future<Either<Failure, AccountModel>> add(dynamic entity);

  @override
  DataSource buildDataSource(String path);

  Future<Either<Failure, AccountModel>> changePasswordAccount(
      dynamic id, dynamic entity);

  @override
  Future<Either<Failure, AccountModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<AccountModel>>> filter(
      Map<String, dynamic> filters);

  @override
  Future<Either<Failure, AccountModel>> get(dynamic entityId);

  Future<Either<Failure, AccountModel>> getAccount(dynamic id);

  Future<Either<Failure, AccountModel>> getAccountModel(dynamic params);

  @override
  Future<Either<Failure, EntityModelList<AccountModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<AccountModel>>> getBy(Map params);

  Future<Either<Failure, EntityModelList<DestinatarioModel>>> getDestinatarios(
      dynamic entity);

  Future<Either<Failure, AccountModel>> getDisableTotp();

  Future<Either<Failure, AccountModel>> getRefreshTotp();

  Future<Either<Failure, AccountModel>> getTotp();

  Future<Either<Failure, AccountModel>> getVerifyTotp(dynamic entity);

  @override
  Future<Either<Failure, EntityModelList<AccountModel>>> paginate(
      int start, int limit, Map params);

  Future<Either<Failure, AccountModel>> resetPaymentPassword(
      dynamic id, dynamic entity);

  @override
  Future<Either<Failure, AccountModel>> update(
      dynamic entityId, dynamic entity);
}
