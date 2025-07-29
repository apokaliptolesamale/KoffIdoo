import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';

import '/app/modules/warranty/domain/usecases/add_warranty_usecase.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/interfaces/body_request.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/header_request.dart';
import '../../../../core/services/paths_service.dart';
import '../../data/datasources/warranty_datasource.dart';
import '../../domain/entities/warranty.dart';
import '../../domain/models/warranty_model.dart';
import '../../domain/repository/warranty_repository.dart';

class WarrantyRepositoryImpl<WarrantyModelType extends Warranty>
    implements WarrantyRepository<WarrantyModelType> {
  late DataSource? datasource;

  WarrantyRepositoryImpl();

  @override
  Future<Either<Failure, WarrantyModelType>> add(entity) async {
    try {
      if (entity is Map) {
        entity = warrantyModelFromJson(json.encode(entity)).toJson();
      } else if (entity is AddUseCaseWarrantyParams) {
        entity = entity.toJson();
        //entity = warrantyModelFromJson(json.encode(entity.toJson())).toJson();
      }

      String url = PathsService.warrantyUrlService;
      buildDataSource(url);
      final warranty = await datasource!.getProvider.addEntity(entity);
      return warranty.fold(
          (l) => Left(ServerFailure(message: l.toString())), (r) => Right(r));
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  DataSource buildDataSource(String path) => _buildDataSource(path);

  @override
  Future<Either<Failure, WarrantyModelType>> delete(dynamic entityId) async {
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
      final warranty = await datasource!.request(url, body, header);
      return Right(warranty);
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
  Future<Either<Failure, EntityModelList<WarrantyModelType>>> filter(
      Map<String, dynamic> filters) async {
    try {
      String url = PathsService.warrantyUrlService;
      buildDataSource(url);
      final result = await datasource!.getProvider.filter(filters);
      return result.fold((l) {
        return Left(ServerFailure(message: l.toString()));
      }, (r) => Right(r));
    } on ServerException catch (ex) {
      return Left(ServerFailure(message: ex.message));
    }
  }

  @override
  Future<Either<Failure, WarrantyModelType>> get(dynamic entityId) async {
    try {
      String url = PathsService.warrantyUrlService;
      buildDataSource(url);
      final result = await datasource!.getProvider.getEntity(entityId);
      return result.fold((l) {
        return Left(ServerFailure(message: l.toString()));
      }, (r) => Right(r));
    } on ServerException catch (ex) {
      return Left(ServerFailure(message: ex.message));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<WarrantyModelType>>> getAll() async {
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
      final warrantys = await datasource!.request(url, body, header);
      return warrantys.fold(
          (l) => Left(ServerFailure(message: l.toString())), (r) => Right(r));
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<WarrantyModelType>>> getBy(
      Map params) async {
    try {
      final warrantyList = await datasource!.getAll();

      FutureOr<Either<Failure, EntityModelList<WarrantyModelType>>> process(
          EntityModelList<WarrantyModelType> list) {
        EntityModelList<WarrantyModelType> listToReturn =
            DefaultEntityModelList<WarrantyModelType>();
        params.forEach((key, value) {
          final itemsList = list.getList();
          for (var element in itemsList) {
            final json = (element as WarrantyModel).toJson();
            if (json.containsKey(key) && json[value] == value) {
              listToReturn.getList().add(element);
            }
          }
        });

        return Right(listToReturn);
      }

      return warrantyList.fold(
          (l) => Left(ServerFailure(message: l.toString())),
          (r) => process(r.warranty));
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
  Future<Either<Failure, WarrantyModelType>> getWarranty(dynamic id) => get(id);

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
  Future<Either<Failure, EntityModelList<WarrantyModelType>>> paginate(
      int start, int limit, Map params) async {
    try {
      buildDataSource(PathsService.apiOperationHost);

      EntityModelList<WarrantyModelType> operations = await datasource!
          .getProvider
          .paginate<EntityModelList<WarrantyModelType>>(
              start, limit, params) as EntityModelList<WarrantyModelType>;

      return Right(operations);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, WarrantyModelType>> update(
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
      final warranty = await datasource!.request(url, body, header);
      return Right(warranty);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  DataSource _buildDataSource(String path) {
    path = path.toLowerCase();
    RegExp remoteRegExp = RegExp(
      r'^(http)|(https)|(ftp)|(ftps)|(ws)|(wss)|(mms)|(mmss)$',
      caseSensitive: true,
      multiLine: false,
    );
    if (path.startsWith(remoteRegExp)) {
      datasource = RemoteWarrantyDataSourceImpl();
    } else {
      datasource = LocalWarrantyDataSourceImpl();
    }
    datasource!.getProvider.setBaseUrl(path);
    return datasource!;
  }
}
