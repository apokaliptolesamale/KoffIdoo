import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/interfaces/body_request.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/header_request.dart';
import '../../../../core/services/local_storage.dart';
import '../../../../core/services/manager_authorization_service.dart';
import '../../../../core/services/paths_service.dart';
import '../../data/datasources/operation_datasource.dart';
import '../../domain/models/operation_model.dart';
import '../../domain/repository/operation_repository.dart';

class OperationRepositoryImpl<OperationModelType extends OperationModel>
    implements OperationRepository<OperationModelType> {
  late DataSource? datasource;

  OperationRepositoryImpl();

  @override
  Future<Either<Failure, OperationModelType>> add(entity) async {
    try {
      if (entity is Map) {
        entity = operationModelFromJson(json.encode(entity));
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
      final operation = await datasource!.request(url, body, header);
      return Right(operation);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  DataSource buildDataSource(String path) => _buildDataSource(path);

  @override
  Future<Either<Failure, OperationModelType>> delete(dynamic entityId) async {
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
      final operation = await datasource!.request(url, body, header);
      return Right(operation);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
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
  Future<Either<Failure, EntityModelList<OperationModelType>>> filter(
      Map<String, dynamic> filters) async {
    final mas = ManagerAuthorizationService().get(PathsService.identityKey);
    if (mas != null) {
      buildDataSource("https://${PathsService.apiEndpoint}");

      var operation = await (datasource as RemoteOperationDataSourceImpl)
          .filter<EntityModelList<OperationModelType>>(filters);
      return operation.fold((l) => Left(ServerFailure(message: l.toString())),
          (operation) {
        //LocalSecureStorage.storage.write("operation", json.encode(operation));
        return Right(operation);
      });
    }
    return Left(NulleableFailure(
        message: "La instancia de ManagerAuthorizationService es nula."));
  }

  @override
  Future<Either<Failure, OperationModelType>> get(dynamic entityId) async {
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
      final operation = await datasource!.request(url, body, header);
      return Right(operation);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<OperationModelType>>> getAll() async {
    try {
      String url = "https://${PathsService.apiEndpoint}";

      buildDataSource(url);
      var operations = await (datasource as RemoteOperationDataSourceImpl)
          .getAll<EntityModelList<OperationModelType>>();
      return operations.fold((l) => Left(ServerFailure(message: l.toString())),
          (operations) {
        LocalSecureStorage.storage.write("operation", json.encode(operations));
        return Right(operations);
      });
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<OperationModelType>>> getBy(
      Map params) async {
    try {
      final operationList = await datasource!.getAll();

      FutureOr<Either<Failure, EntityModelList<OperationModelType>>> process(
          EntityModelList<OperationModelType> list) {
        EntityModelList<OperationModelType> listToReturn =
            DefaultEntityModelList<OperationModelType>();
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

      return operationList.fold(
          (l) => Left(ServerFailure(message: l.toString())),
          (r) => process(r.operation));
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
  Future<Either<Failure, OperationModelType>> getOperation(dynamic id) =>
      get(id);

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
  Future<Either<Failure, EntityModelList<OperationModelType>>> paginate(
      int start, int limit, Map params) async {
    try {
      buildDataSource(PathsService.apiOperationHost);

      EntityModelList<OperationModelType> operations = await datasource!
          .getProvider
          .paginate<EntityModelList<OperationModelType>>(
              start, limit, params) as EntityModelList<OperationModelType>;

      return Right(operations);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, OperationModelType>> update(
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
      final operation = await datasource!.request(url, body, header);
      return Right(operation);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  DataSource _buildDataSource(String path) {
    path = path.toLowerCase();

    RegExp remoteRegExp = RegExp(
      r'^(http)|(https)|(ftp)|(ftps)|(ws)|(wss)]|(mms)$',
      caseSensitive: true,
      multiLine: false,
    );
    if (path.startsWith(remoteRegExp)) {
      datasource = RemoteOperationDataSourceImpl();
    } else {
      datasource = LocalOperationDataSourceImpl();
    }
    datasource!.getProvider.setBaseUrl(path);
    return datasource!;
  }
}
