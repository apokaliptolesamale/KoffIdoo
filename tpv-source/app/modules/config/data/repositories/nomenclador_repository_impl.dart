import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';

import '/app/core/services/logger_service.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/interfaces/body_request.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/header_request.dart';
import '../../../../core/services/paths_service.dart';
import '../../data/datasources/nomenclador_datasource.dart';
import '../../domain/models/nomenclador_model.dart';
import '../../domain/repository/nomenclador_repository.dart';

class NomencladorRepositoryImpl<NomencladorModelType>
    implements NomencladorRepository<NomencladorModelType> {
  late DataSource? datasource;

  NomencladorRepositoryImpl();

  @override
  Future<Either<Failure, NomencladorModelType>> add(entity) async {
    try {
      if (entity is Map) {
        entity = nomencladorModelFromJson(json.encode(entity));
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
      final nomenclador = await datasource!.request(url, body, header);
      return Right(nomenclador);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  DataSource buildDataSource(String path) => _buildDataSource(path);

  @override
  Future<Either<Failure, NomencladorModelType>> delete(dynamic entityId) async {
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
      final nomenclador = await datasource!.request(url, body, header);
      return Right(nomenclador);
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
  Future<Either<Failure, EntityModelList<NomencladorModelType>>> filter(
      Map<String, dynamic> filters) async {
    try {
      String url = PathsService.nomUrlService;
      final response = getDataSourcePath<LocalNomencladorDataSourceImpl,
          RemoteNomencladorDataSourceImpl>(url);
      final data = await response.fold((l) {
        return l.filter<NomencladorModelType>(filters);
      }, (r) {
        return r.filter<NomencladorModelType>(filters);
      });
      return data.fold((l) => Left(ServerFailure(message: l.toString())), (r) {
        log(r.toString());
        final result = FlexibleEntityModelList<NomencladorModelType>();
        result.fromList([r]);
        return Right(result);
      });
      /*if (response.isRight()) {
        final tmp = (response as Right).value;
        return tmp.getProvider
            .filter<EntityModelList<NomencladorModelType>>(filters);
      }*/
      //return Left(ServerFailure(message: 'No implementado'));
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, NomencladorModelType>> get(dynamic entityId) async {
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
      final nomenclador = await datasource!.request(url, body, header);
      return Right(nomenclador);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<NomencladorModelType>>>
      getAll() async {
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
      final nomencladors = await datasource!.request(url, body, header);
      return nomencladors.fold(
          (l) => Left(ServerFailure(message: l.toString())), (r) => Right(r));
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<NomencladorModelType>>> getBy(
      Map params) async {
    try {
      final nomencladorList = await datasource!.getAll();

      FutureOr<Either<Failure, EntityModelList<NomencladorModelType>>> process(
          EntityModelList<NomencladorModelType> list) {
        EntityModelList<NomencladorModelType> listToReturn =
            DefaultEntityModelList<NomencladorModelType>();
        params.forEach((key, value) {
          final itemsList = list.getList();
          for (var element in itemsList) {
            final json = (element as EntityModel).toJson();
            if (json.containsKey(key) && json[value] == value) {
              listToReturn.getList().add(element);
            }
          }
        });

        return Right(listToReturn);
      }

      return nomencladorList.fold(
          (l) => Left(ServerFailure(message: l.toString())),
          (r) => process(r.nomenclador));
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<NomencladorModelType>>>
      getComercialUnits() async {
    try {
      final datasource = _buildDataSource("");
      final result = await (datasource as RemoteNomencladorDataSourceImpl)
          .getComercialUnits();
      return result.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) {
        return Right(r);
      });
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  Future<Either<Failure, EntityModelList<NomencladorModelType>>>
      getComercialUnitsFromAssets() {
    // TODO: implement getComercialUnitsFromAssets
    throw UnimplementedError();
  }

  @override
  Either<Local, Remote> getDataSourcePath<Local, Remote>(String path) {
    buildDataSource(path);
    return isRemote(path)
        ? Right(datasource as Remote)
        : Left(datasource as Local);
  }

  @override
  Future<Either<Failure, NomencladorModelType>> getNomenclador(dynamic id) =>
      get(id);

  @override
  Future<Either<Failure, EntityModelList<NomencladorModelType>>>
      getNomencladoresByClientId(String clientId) async {
    try {
      final datasource = _buildDataSource(PathsService.nomUrlService);
      final result = await (datasource as RemoteNomencladorDataSourceImpl)
          .getComercialUnits();
      return result.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) {
        return Right(r);
      });
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<NomencladorModelType>>>
      getPaymentTypesFromAssets() async {
    try {
      final datasource = _buildDataSource("");
      final result = await (datasource as LocalNomencladorDataSourceImpl)
          .getPaymentTypesFromAssets();
      return result.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) {
        return Right(r);
      });
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<NomencladorModelType>>>
      getProvinciasFromAssets() async {
    try {
      final datasource = _buildDataSource("");
      final result = await (datasource as LocalNomencladorDataSourceImpl)
          .getProvinciasFromAssets();
      return result.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) {
        return Right(r);
      });
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<NomencladorModelType>>>
      getTrdUnitsFromAssets() async {
    try {
      final datasource = _buildDataSource("");
      final result = await (datasource as LocalNomencladorDataSourceImpl)
          .getTrdUnitsFromAssets();
      return result.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) {
        return Right(r);
      });
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
  Future<Either<Failure, EntityModelList<NomencladorModelType>>> paginate(
      int start, int limit, Map params) async {
    try {
      buildDataSource(PathsService.apiOperationHost);

      EntityModelList<NomencladorModelType> operations = await datasource!
          .getProvider
          .paginate<EntityModelList<NomencladorModelType>>(
              start, limit, params) as EntityModelList<NomencladorModelType>;

      return Right(operations);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, NomencladorModelType>> update(
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
      final nomenclador = await datasource!.request(url, body, header);
      return Right(nomenclador);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  DataSource _buildDataSource(String path) {
    path = path.toLowerCase();
    if (isRemote(path)) {
      datasource = RemoteNomencladorDataSourceImpl();
    } else {
      datasource = LocalNomencladorDataSourceImpl();
    }
    datasource!.getProvider.setBaseUrl(path);
    return datasource!;
  }
}
