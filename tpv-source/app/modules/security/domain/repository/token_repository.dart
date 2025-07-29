import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';

abstract class TokenRepository<User> extends Repository<User> {
  @override
  Future<Either<Failure, User>> add(dynamic entity);

  @override
  Future<Either<Failure, User>> delete(dynamic entityId);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, User>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<User>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<User>>> getBy(Map params);

  Future<Either<Failure, User>> getUser(dynamic id);

  @override
  Future<Either<Failure, User>> update(dynamic entityId, dynamic entity);
}
