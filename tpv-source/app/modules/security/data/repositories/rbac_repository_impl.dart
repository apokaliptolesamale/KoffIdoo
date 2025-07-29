import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/interfaces/body_request.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/header_request.dart';
import '../../../../core/services/paths_service.dart';
import '../../data/datasources/rbac_datasource.dart';
import '../../domain/models/rbac_model.dart';
import '../../domain/repository/rbac_repository.dart';

class RbacRepositoryImpl<RbacModelType extends RbacModel>
    implements RbacRepository<RbacModelType> {
  late DataSource? datasource;

  RbacRepositoryImpl();

  @override
  Future<Either<Failure, RbacModelType>> add(entity) async {
    try {
      if (entity is Map) {
        entity = rbacModelFromJson(json.encode(entity));
      }
      //TODO Asigne la url del API o recurso para adicionar
      String url = "Url to add";
      //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
      BodyRequest body = EmptyBodyRequest();
      //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
      HeaderRequest header = HeaderRequestImpl(
        idpKey: "apiez",
      );
      buildDataSource(url);
      final rbac = await datasource!.request(url, body, header);
      return Right(rbac);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  addPermissionsToRole(int id) {
    // TODO: implement addPermissionsToRole
    throw UnimplementedError();
  }

  @override
  addRolesToUsers(int id) {
    // TODO: implement addRolesToUsers
    throw UnimplementedError();
  }

  @override
  addUsersToRole(int id) {
    // TODO: implement addUsersToRole
    throw UnimplementedError();
  }

  @override
  DataSource buildDataSource(String path) => _buildDataSource(path);

  @override
  createPermissions(int id) {
    // TODO: implement createPermissions
    throw UnimplementedError();
  }

  @override
  createRole(int id) {
    // TODO: implement createRole
    throw UnimplementedError();
  }

  @override
  createUser(int id) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, RbacModelType>> delete(dynamic entityId) async {
    try {
      //TODO Asigne la url del API o recurso para adicionar
      String url = "Url to delete";
      //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
      BodyRequest body = EmptyBodyRequest();
      //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
      HeaderRequest header = HeaderRequestImpl(
        idpKey: "apiez",
      );
      buildDataSource(url);
      final rbac = await datasource!.request(url, body, header);
      return Right(rbac);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  deletePermissions(int id) {
    // TODO: implement deletePermissions
    throw UnimplementedError();
  }

  @override
  deleteRoles(int id) {
    // TODO: implement deleteRoles
    throw UnimplementedError();
  }

  @override
  deleteUsers(int id) {
    // TODO: implement deleteUsers
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> exists(entityId) async {
    final result = await get(entityId);
    return result.fold((exception) {
      return Left(ServerFailure(message: 'Error !!!'));
    }, (model) {
      return Right(true);
    });
  }

  @override
  Future<Either<Failure, EntityModelList<RbacModelType>>> filter(
      Map<String, dynamic> filters) async {
    try {
      //TODO Asigne la url del API o recurso para adicionar
      String url = "Url to get by field";
      //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
      BodyRequest body = EmptyBodyRequest();
      //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
      HeaderRequest header = HeaderRequestImpl(
        idpKey: "apiez",
      );
      buildDataSource(url);
      final rbacs = await datasource!.request(url, body, header);
      return Right(rbacs);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  filterPermission(int id) {
    // TODO: implement filterPermission
    throw UnimplementedError();
  }

  @override
  filterRole(int id) {
    // TODO: implement filterRole
    throw UnimplementedError();
  }

  @override
  filterUsers(int id) {
    // TODO: implement filterUsers
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, RbacModelType>> get(dynamic entityId) async {
    try {
      //TODO Asigne la url del API o recurso para adicionar
      String url = "Url to get";
      //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
      BodyRequest body = EmptyBodyRequest();
      //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
      HeaderRequest header = HeaderRequestImpl(
        idpKey: "apiez",
      );
      buildDataSource(url);
      final rbac = await datasource!.request(url, body, header);
      return Right(rbac);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<RbacModelType>>> getAll() async {
    try {
      //TODO Asigne la url del API o recurso para adicionar
      String url = "Url to get by field";
      //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
      BodyRequest body = EmptyBodyRequest();
      //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
      HeaderRequest header = HeaderRequestImpl(
        idpKey: "apiez",
      );
      buildDataSource(url);
      final rbacs = await datasource!.request(url, body, header);
      return rbacs.fold(
          (l) => Left(ServerFailure(message: l.toString())), (r) => Right(r));
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<RbacModelType>>> getBy(
      Map params) async {
    try {
      final rbacList = await datasource!.getAll();

      FutureOr<Either<Failure, EntityModelList<RbacModelType>>> process(
          EntityModelList<RbacModelType> list) {
        EntityModelList<RbacModelType> listToReturn =
            DefaultEntityModelList<RbacModelType>();
        params.forEach((key, value) {
          final itemsList = list.getList();
          for (var element in itemsList) {
            final json = (element).toJson();
            if (json.containsKey(key) && json[value] == value) {
              listToReturn.getList().add(element);
            }
          }
        });

        return Right(listToReturn);
      }

      return rbacList.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) => process(r.rbac));
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Either<Local, Remote> getDataSourcePath<Local, Remote>(String path) {
    buildDataSource(path);
    return isRemote(path)
        ? Right(datasource as Remote)
        : Left(datasource as Local);
  }

  @override
  Future<Either<Failure, RbacModelType>> getRbac(dynamic id) => get(id);

  @override
  getUserRoles(int id) {
    // TODO: implement getUserRoles
    throw UnimplementedError();
  }

  @override
  bool isRemote(String path) {
    path = path.toLowerCase();

    RegExp remoteRegExp = RegExp(
      r'^(http)|(https)|(ftp)|(ftps)|(ws)|(wss)]|(mms)$',
      caseSensitive: true,
      multiLine: false,
    );
    return path.startsWith(remoteRegExp);
  }

  @override
  listPermissions(int id) {
    // TODO: implement listPermissions
    throw UnimplementedError();
  }

  @override
  listRoles(int id) {
    // TODO: implement listRoles
    throw UnimplementedError();
  }

  @override
  listUsers(int id) {
    // TODO: implement listUsers
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, RbacModelType>> loadRoles(String path) async {
    final response = await getDataSourcePath<LocalRbacDataSourceImpl,
            RemoteRbacDataSourceImpl>(path)
        .fold((l) {
      return l.loadRoles<RbacModelType>(path);
    }, (r) {
      return r.loadRoles<RbacModelType>(path);
    });
    return response.fold(
        (l) => Left(ServerFailure(
              message: l.toString(),
            )), (r) {
      return Right(r);
    });
  }

  @override
  Future<Either<Failure, EntityModelList<RbacModelType>>> paginate(
      int start, int limit, Map params) async {
    try {
      buildDataSource(PathsService.apiOperationHost);

      EntityModelList<RbacModelType> operations = await datasource!.getProvider
              .paginate<EntityModelList<RbacModelType>>(start, limit, params)
          as EntityModelList<RbacModelType>;

      return Right(operations);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  removePermissionsOnRole(int id) {
    // TODO: implement removePermissionsOnRole
    throw UnimplementedError();
  }

  @override
  syncRoles(int id) {
    // TODO: implement syncRoles
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, RbacModelType>> update(
      dynamic entityId, entity) async {
    try {
      //TODO Asigne la url del API o recurso para adicionar
      String url = "Url to update";
      //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
      BodyRequest body = EmptyBodyRequest();
      //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
      HeaderRequest header = HeaderRequestImpl(
        idpKey: "apiez",
      );
      buildDataSource(url);
      final rbac = await datasource!.request(url, body, header);
      return Right(rbac);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  updatePermission(int id) {
    // TODO: implement updatePermission
    throw UnimplementedError();
  }

  @override
  updateRole(int id) {
    // TODO: implement updateRole
    throw UnimplementedError();
  }

  @override
  updateUser(int id) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  DataSource _buildDataSource(String path) {
    if (isRemote(path)) {
      datasource = RemoteRbacDataSourceImpl();
    } else {
      datasource = LocalRbacDataSourceImpl();
    }
    datasource!.getProvider.setBaseUrl(path);
    return datasource!;
  }
}
