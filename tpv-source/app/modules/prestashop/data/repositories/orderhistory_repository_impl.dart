import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';

import '/app/core/services/logger_service.dart';
import '/app/modules/prestashop/service/presta_shop_web_service_factory.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/interfaces/body_request.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/header_request.dart';
import '../../../../core/services/paths_service.dart';
import '../../domain/models/orderhistory_model.dart';
import '../../domain/repository/orderhistory_repository.dart';
import '../datasources/orderhistory_datasource.dart';

class OrderHistoryRepositoryImpl<
        OrderHistoryModelType extends OrderHistoryModel>
    implements OrderHistoryRepository<OrderHistoryModelType> {
  late DataSource? datasource;

  OrderHistoryRepositoryImpl();

  @override
  Future<Either<Failure, OrderHistoryModelType>> add(entity) async {
    try {
      if (entity is Map) {
        entity = orderhistoryModelFromJson(json.encode(entity));
      }
      if (PrestaShopWebServiceFactory.instance.hasActiveWebService) {
        String url = PrestaShopWebServiceFactory
            .instance.getActiveWebService!.getApi.url;
        log("Utilizando url del api de prestashop:${url.substring(url.indexOf("@") + 1, url.length)}");
        buildDataSource(url);
      } else {
        log("No hay servicio de prestashop inicializado, ésto generará un datasource vacío y posibles errores.");
      }
      final added = await datasource!.addEntity(entity);
      return added.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) => Right(r as OrderHistoryModelType));
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  DataSource buildDataSource(String path) => _buildDataSource(path);

  @override
  Future<Either<Failure, OrderHistoryModelType>> delete(
      dynamic entityId) async {
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
      final orderhistory = await datasource!.request(url, body, header);
      return Right(orderhistory);
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
  Future<Either<Failure, EntityModelList<OrderHistoryModelType>>> filter(
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
      final orderhistorys = await datasource!.request(url, body, header);
      return Right(orderhistorys);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, OrderHistoryModelType>> get(dynamic entityId) async {
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
      final orderhistory = await datasource!.request(url, body, header);
      return Right(orderhistory);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<OrderHistoryModelType>>>
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
      final orderhistorys = await datasource!.request(url, body, header);
      return orderhistorys.fold(
          (l) => Left(ServerFailure(message: l.toString())), (r) => Right(r));
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<OrderHistoryModelType>>> getBy(
      Map params) async {
    try {
      final orderhistoryList = await datasource!.getAll();

      FutureOr<Either<Failure, EntityModelList<OrderHistoryModelType>>> process(
          EntityModelList<OrderHistoryModelType> list) {
        EntityModelList<OrderHistoryModelType> listToReturn =
            DefaultEntityModelList<OrderHistoryModelType>();
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

      return orderhistoryList.fold(
          (l) => Left(ServerFailure(message: l.toString())),
          (r) => process(r.orderhistory));
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, OrderHistoryModelType>> getOrderHistory(dynamic id) =>
      get(id);

  @override
  Future<Either<Failure, EntityModelList<OrderHistoryModelType>>> paginate(
      int start, int limit, Map params) async {
    try {
      buildDataSource(PathsService.apiOperationHost);

      EntityModelList<OrderHistoryModelType> operations = await datasource!
          .getProvider
          .paginate<EntityModelList<OrderHistoryModelType>>(
              start, limit, params) as EntityModelList<OrderHistoryModelType>;

      return Right(operations);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, OrderHistoryModelType>> update(
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
      final orderhistory = await datasource!.request(url, body, header);
      return Right(orderhistory);
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
      r'^(http)|(https)|(ftp)|(ftps)|(ws)|(wss)]|(mms)$',
      caseSensitive: true,
      multiLine: false,
    );
    if (path.startsWith(remoteRegExp)) {
      datasource = RemoteOrderHistoryDataSourceImpl();
    } else {
      datasource = LocalOrderHistoryDataSourceImpl();
    }
    datasource!.getProvider.baseUrl = path;
    return datasource!;
  }
}
