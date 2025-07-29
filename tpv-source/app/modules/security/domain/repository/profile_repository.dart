import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';

abstract class ProfileRepository<Profile> extends Repository<Profile> {
  @override
  Future<Either<Failure, Profile>> add(dynamic entity);

  @override
  Future<Either<Failure, Profile>> delete(dynamic entityId);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, Profile>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<Profile>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<Profile>>> getBy(Map params);

  Future<Either<Failure, Profile>> getProfile(dynamic id);

  @override
  Future<Either<Failure, Profile>> update(dynamic entityId, dynamic entity);
}
