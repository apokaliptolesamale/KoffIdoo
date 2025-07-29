import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';

abstract class RbacRepository<RbacModel> extends Repository<RbacModel> {
  @override
  Future<Either<Failure, RbacModel>> add(dynamic entity);

  addPermissionsToRole(int id) {}

  addRolesToUsers(int id) {}

  addUsersToRole(int id) {}

  @override
  DataSource buildDataSource(String path);

  createPermissions(int id) {}

  createRole(int id) {}

  createUser(int id) {}

  @override
  Future<Either<Failure, RbacModel>> delete(dynamic entityId);

  deletePermissions(int id) {}

  deleteRoles(int id) {}

  deleteUsers(int id) {}

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<RbacModel>>> filter(
      Map<String, dynamic> filters);

  filterPermission(int id) {}

  filterRole(int id) {}

  filterUsers(int id) {}

  @override
  Future<Either<Failure, RbacModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<RbacModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<RbacModel>>> getBy(Map params);

  Future<Either<Failure, RbacModel>> getRbac(dynamic id);

  getUserRoles(int id) {}

  listPermissions(int id) {}

  listRoles(int id) {}

  listUsers(int id) {}

  Future<Either<Failure, RbacModel>> loadRoles(String path);

  @override
  Future<Either<Failure, EntityModelList<RbacModel>>> paginate(
      int start, int limit, Map params);

  removePermissionsOnRole(int id) {}

  syncRoles(int id) {}

  @override
  Future<Either<Failure, RbacModel>> update(dynamic entityId, dynamic entity);

  updatePermission(int id) {}

  updateRole(int id) {}

  updateUser(int id) {}
}
