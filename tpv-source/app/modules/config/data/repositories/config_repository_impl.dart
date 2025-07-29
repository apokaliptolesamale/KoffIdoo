import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../../../app/core/services/logger_service.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/interfaces/body_request.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/header_request.dart';
import '../../../../core/services/paths_service.dart';
import '../../data/datasources/config_datasource.dart';
import '../../domain/models/config_model.dart';
import '../../domain/repository/config_repository.dart';

class ConfigRepositoryImpl<ConfigModel>
    implements ConfigRepository<ConfigModel> {
  late DataSource? datasource;

  ConfigRepositoryImpl();

  @override
  Future<Either<Failure, ConfigModel>> add(entity) async {
    try {
      //TODO Asigne la url del API o recurso para adicionar
      String url = "Url to add";
      //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
      BodyRequest body = EmptyBodyRequest();
      //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
      HeaderRequest header = HeaderRequestImpl(
        idpKey: "apiez",
      );
      buildDataSource(url);
      final config = await datasource!.request(url, body, header);
      return Right(config);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  DataSource buildDataSource(String path) => _buildDataSource(path);

  @override
  Future<Either<Failure, ConfigModel>> delete(dynamic entityId) async {
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
      final config = await datasource!.request(url, body, header);
      return Right(config);
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
  Future<Either<Failure, EntityModelList<ConfigModel>>> filter(
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
      final configs = await datasource!.request(url, body, header);
      return Right(configs);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, ConfigModel>> get(dynamic entityId) async {
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
      final config = await datasource!.request(url, body, header);
      return Right(config);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<ConfigModel>>> getAll() async {
    try {
      String url = "assets/models/config.json";

      buildDataSource(url);
      final configs =
          await datasource!.getProvider.getAll<EntityModelList<ConfigModel>>();
      return configs.fold(
          (l) => Left(ServerFailure(message: l.toString())), (r) => Right(r));
    } on ServerException catch (se) {
      log(se.message);
      return Left(
          ServerFailure(message: 'Error iniciando configuración inicial...'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<ConfigModel>>> getBy(
      Map params) async {
    try {
      final configList = await datasource!.getProvider.getAll();

      FutureOr<Either<Failure, EntityModelList<ConfigModel>>> process(
          EntityModelList<ConfigModel> list) {
        EntityModelList<ConfigModel> listToReturn =
            ConfigList.empty() as EntityModelList<ConfigModel>;
        params.forEach((key, value) {
          for (var element in (list as ConfigList).getList()) {
            final json = element.toJson();
            if (json.containsKey(key) && json[value] == value) {
              listToReturn.getList().add(element as ConfigModel);
            }
          }
        });

        return Right(listToReturn);
      }

      return configList.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) => process(r.config));
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, ConfigModel>> getConfig(dynamic id) => get(id);

  @override
  Future<Either<Failure, EntityModelList<ConfigModel>>> paginate(
      int start, int limit, Map params) async {
    try {
      buildDataSource(PathsService.apiOperationHost);

      EntityModelList<ConfigModel> operations = await datasource!.getProvider
              .paginate<EntityModelList<ConfigModel>>(start, limit, params)
          as EntityModelList<ConfigModel>;

      return Right(operations);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, ConfigModel>> update(dynamic entityId, entity) async {
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
      final config = await datasource!.request(url, body, header);
      return Right(config);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
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
  Either<Local, Remote> getDataSourcePath<Local, Remote>(String path) {
    buildDataSource(path);
    return isRemote(path)
        ? Right(datasource as Remote)
        : Left(datasource as Local);
  }

  DataSource _buildDataSource(String path) {
    path = path.toLowerCase();
    RegExp remoteRegExp = RegExp(
      r'^(http)|(https)|(ftp)|(ftps)|(ws)|(wss)|(mms)|(mmss)$',
      caseSensitive: true,
      multiLine: false,
    );
    if (path.startsWith(remoteRegExp)) {
      datasource = RemoteConfigDataSourceImpl();
    }
    {
      datasource = LocalConfigDataSourceImpl();
    }
    datasource!.getProvider.setBaseUrl(path);
    return datasource!;
  }
}
