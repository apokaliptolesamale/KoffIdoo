import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';

import '/app/modules/order/data/providers/order_provider.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/interfaces/body_request.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/header_request.dart';
import '../../../../core/services/paths_service.dart';
import '../../domain/models/order_model.dart';
import '../../domain/repository/order_repository.dart';
import '../datasources/order_datasource.dart';

class OrderRepositoryImpl<OrderModelType extends OrderModel>
    implements OrderRepository<OrderModelType> {
  late DataSource? datasource;

  OrderRepositoryImpl();

  @override
  Future<Either<Failure, OrderModelType>> add(entity) async {
    try {
      if (entity is Map) {
        entity = orderModelFromJson(json.encode(entity));
      }
      final url = PathsService.orderUrlService; //;
      buildDataSource(url);
      final order = await datasource!.addEntity<OrderModelType>(entity);
      return order.fold(
          (l) => Left(ServerFailure(
                message: l.toString(),
              )),
          (r) => Right(r));
    } on ServerException {
      return Left(ServerFailure(message: 'Error en el servicio.'));
    }
  }

  @override
  DataSource buildDataSource(String path) => _buildDataSource(path);

  @override
  Future<Either<Failure, OrderModelType>> delete(dynamic entityId) async {
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
      final order = await datasource!.request(url, body, header);
      return Right(order);
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
  Future<Either<Failure, EntityModelList<OrderModelType>>> filter(
      Map<String, dynamic> filters) async {
    try {
      final url = PathsService.orderUrlService; //;
      buildDataSource(url);
      final orders = await datasource!.getProvider
          .filter<EntityModelList<OrderModelType>>(filters);
      return orders.fold(
          (l) => Left(ServerFailure(message: l.toString())), (r) => Right(r));
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, OrderModelType>> get(dynamic entityId) async {
    try {
      final url = PathsService.orderUrlService; //;
      buildDataSource(url);
      final result =
          await (datasource!.getProvider as OrderProvider).getOrder(entityId);
      return result.fold(
          (l) => Left(ServerFailure(message: l.toString())), (r) => Right(r));
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<OrderModelType>>> getAll() async {
    try {
      final url = PathsService.orderUrlService; //"./models/orders.json";
      //BodyRequest body = EmptyBodyRequest();
      //HeaderRequest header = HeaderRequestImpl();
      buildDataSource(url);
      final orders = await datasource!.getProvider
          .getAll<EntityModelList<OrderModelType>>();
      return orders.fold(
          (l) => Left(ServerFailure(message: l.toString())), (r) => Right(r));
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<OrderModelType>>> getBy(
      Map params) async {
    try {
      final orderList = await datasource!.getAll();

      FutureOr<Either<Failure, EntityModelList<OrderModelType>>> process(
          EntityModelList<OrderModelType> list) {
        EntityModelList<OrderModelType> listToReturn =
            DefaultEntityModelList<OrderModelType>();
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

      return orderList.fold(
          (l) => Left(ServerFailure(message: l.toString())), (r) => Right(r));
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
  Future<Either<Failure, OrderModelType>> getOrder(dynamic id) => get(id);

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
  Future<Either<Failure, EntityModelList<OrderModelType>>> paginate(
      int start, int limit, Map params) async {
    try {
      buildDataSource(PathsService.apiOperationHost);

      EntityModelList<OrderModelType> operations = await datasource!.getProvider
              .paginate<EntityModelList<OrderModelType>>(start, limit, params)
          as EntityModelList<OrderModelType>;

      return Right(operations);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, OrderModelType>> update(
      dynamic entityId, entity) async {
    try {
      final url = PathsService.orderUrlService;
      buildDataSource(url);
      final orders = await datasource!.getProvider
          .updateEntity<OrderModelType>(entityId, entity);
      return orders.fold((l) => Left(ServerFailure(message: l.toString())),
          (order) => Right(order));
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
      datasource = RemoteOrderDataSourceImpl();
    } else {
      datasource = LocalOrderDataSourceImpl();
    }
    datasource!.getProvider.setBaseUrl(path);
    return datasource!;
  }
}
