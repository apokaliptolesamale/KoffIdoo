import 'dart:developer';

import 'package:dartz/dartz.dart';

import '/app/core/config/errors/errors.dart';
import '/app/core/constants/IDPConstantes.dart';
import '/app/core/interfaces/data_source.dart';
import '/app/core/interfaces/entity_model.dart';
import '/app/core/services/manager_authorization_service.dart';
import '/app/core/services/paths_service.dart';
import '/app/modules/transaction/data/datasources/config_service_datasource.dart';
import '/app/modules/transaction/domain/repository/config_service_repository.dart';

class ClientServiceRepositoryImpl<ClientServiceModel>
    implements ClientServiceRepository<ClientServiceModel> {
  late DataSource? datasource;

  ClientServiceRepositoryImpl();

  @override
  Future<Either<Failure, ClientServiceModel>> add(entity) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ClientServiceModel>> addClientId(entity) async {
    final ms = ManagerAuthorizationService();
    final mas = ms.get(PathsService.identityKey);
    /* if (entity is Map) {
      entity = clientinvoiceModelFromJson(json.encode(entity));
    }*/
    if (mas != null) {
      String url = API_HOST;
      buildDataSource(url);
      final clientinvoice = await (datasource! as RemoteClientIdDataSourceImpl)
          .addClientId(entity);
      return clientinvoice
          .fold((l) => Left(ServerFailure(message: l.toString())), (r) {
        log(r.toString());
        return Right(r);
      });
    }
    {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  DataSource buildDataSource(String path) => _buildDataSource(path);

  @override
  Future<Either<Failure, ClientServiceModel>> delete(entityId) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> exists(entityId) {
    // TODO: implement exists
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, EntityModelList<ClientServiceModel>>> filter(
      Map<String, dynamic> filters) {
    // TODO: implement filter
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ClientServiceModel>> get(entityId) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, EntityModelList<ClientServiceModel>>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, EntityModelList<ClientServiceModel>>> getBy(
      Map params) {
    // TODO: implement getBy
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, EntityModelList<ClientServiceModel>>> getClientId(
      Map<String, dynamic> params) async {
    final ms = ManagerAuthorizationService();
    final mas = ms.get(PathsService.identityKey);
    log(ms.toString());
    if (mas != null) {
      String url = API_HOST;
      buildDataSource(url);
      final clientIds = await (datasource as RemoteClientIdDataSourceImpl)
          .getClientId(params);
      return clientIds.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) {
        log(r.toString());
        return Right(r);
      });
    }
    return Left(
        NulleableFailure(message: " La instancia ManagerAutorization es nula"));
  }

  @override
  Future<Either<Failure, EntityModelList<ClientServiceModel>>> getClientIds(
      Map<String, dynamic> params) async {
    final ms = ManagerAuthorizationService();
    final mas = ms.get(PathsService.identityKey);
    log(ms.toString());
    if (mas != null) {
      String url = API_HOST;
      buildDataSource(url);
      final clientIds = await (datasource as RemoteClientIdDataSourceImpl)
          .getClientIds(params);
      return clientIds.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) {
        log(r.toString());
        return Right(r);
      });
    }
    return Left(
        NulleableFailure(message: " La instancia ManagerAutorization es nula"));
  }

  @override
  Either<Local, Remote> getDataSourcePath<Local, Remote>(String path) {
    buildDataSource(path);
    return isRemote(path)
        ? Right(datasource as Remote)
        : Left(datasource as Local);
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
  Future<Either<Failure, EntityModelList<ClientServiceModel>>> paginate(
      int start, int limit, Map params) {
    // TODO: implement paginate
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ClientServiceModel>> update(entityId, entity) {
    // TODO: implement update
    throw UnimplementedError();
  }

  DataSource _buildDataSource(String path) {
    path = path.toLowerCase();

    RegExp remoteRegExp = RegExp(
      r'^(http)|(https)|(ftp)|(ftps)|(ws)|(wss)]|(mms)$',
      caseSensitive: true,
      multiLine: false,
    );
    if (path.startsWith(remoteRegExp)) {
      datasource = RemoteClientIdDataSourceImpl();
    } else {
      datasource = LocalClientIdDataSourceImpl();
    }
    datasource!.getProvider.setBaseUrl(path);
    return datasource!;
  }
}
