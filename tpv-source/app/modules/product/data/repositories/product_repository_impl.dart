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
import '../../../product/domain/models/product_model.dart';
import '../../../product/domain/repository/product_repository.dart';
import '../datasources/product_datasource.dart';

class ProductRepositoryImpl<ProductModelType extends ProductModel>
    implements ProductRepository<ProductModelType> {
  late DataSource? datasource;

  ProductRepositoryImpl();

  @override
  Future<Either<Failure, ProductModelType>> add(entity) async {
    try {
      if (entity is Map) {
        entity = productModelFromJson(json.encode(entity));
      }
      final url = PathsService.productUrlService;
      buildDataSource(url);
      final product =
          await datasource!.getProvider.addEntity<ProductModelType>(entity);
      return product.fold(
          (l) => Left(ServerFailure(message: l.toString())), (r) => Right(r));
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  DataSource buildDataSource(String path) => _buildDataSource(path);

  @override
  Future<Either<Failure, ProductModelType>> checkByCode(dynamic code) async {
    try {
      //final url = "assets/models/products.json";
      String url = PathsService.productUrlService;
      buildDataSource(url);
      final result = await (datasource! as RemoteProductDataSourceImpl)
          .checkEntity<ProductModelType>(code);
      return result.fold(
          (l) => Left(ServerFailure(message: l.toString())), (r) => Right(r));
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, ProductModelType>> delete(dynamic entityId) async {
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
      final product = await datasource!.request(url, body, header);
      return Right(product);
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
  Future<Either<Failure, EntityModelList<ProductModelType>>> filter(
      Map<String, dynamic> filters) async {
    try {
      String url = PathsService.productUrlService;
      buildDataSource(url);
      final result = await datasource!.getProvider.filter(filters);

      return result.fold(
          (l) => Left(ServerFailure(message: l.toString())), (r) => Right(r));
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, ProductModelType>> get(dynamic entityId) async {
    try {
      String url = PathsService.productUrlService;
      buildDataSource(url);
      var product = await datasource!.getEntity(entityId);
      return product.fold(
          (l) => Left(ServerFailure(message: l.toString())), (r) => Right(r));
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<ProductModelType>>> getAll() async {
    try {
      final url = "assets/models/products.json";
      buildDataSource(url);
      final productList =
          await datasource!.getAll<EntityModelList<ProductModelType>>();

      return productList.fold(
          (l) => Left(ServerFailure(message: l.toString())), (r) => Right(r));
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<ProductModelType>>> getBy(
      Map params) async {
    try {
      final url = "assets/models/products.json";
      buildDataSource(url);
      final productList =
          await datasource!.getBy<EntityModelList<ProductModelType>>(params);

      FutureOr<Either<Failure, EntityModelList<ProductModelType>>> process(
          EntityModelList<ProductModelType> list) {
        EntityModelList<ProductModelType> listToReturn =
            ProductList.fromJson({"products": []});
        params.forEach((key, value) {
          final itemsList = list.getList();
          for (var element in itemsList) {
            final json = element.toJson();
            if (json.containsKey(key) && json[key] == value) {
              listToReturn.add(element);
            }
          }
        });
        return Right(listToReturn);
      }

      return productList.fold(
          (l) => Left(ServerFailure(message: l.toString())), (r) => process(r));
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
  Future<Either<Failure, ProductModelType>> getProduct(dynamic id) => get(id);

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
  Future<Either<Failure, EntityModelList<ProductModelType>>> paginate(
      int start, int limit, Map params) async {
    try {
      buildDataSource(PathsService.apiOperationHost);

      EntityModelList<ProductModelType> operations = await datasource!
              .getProvider
              .paginate<EntityModelList<ProductModelType>>(start, limit, params)
          as EntityModelList<ProductModelType>;

      return Right(operations);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, ProductModelType>> update(
      dynamic entityId, entity) async {
    try {
      String url = PathsService.productUrlService;
      buildDataSource(url);
      final result =
          await datasource!.getProvider.updateEntity(entityId, entity);

      return result.fold(
          (l) => Left(ServerFailure(message: l.toString())), (r) => Right(r));
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
      datasource = RemoteProductDataSourceImpl();
    } else {
      datasource = LocalProductDataSourceImpl();
    }
    datasource!.getProvider.setBaseUrl(path);
    return datasource!;
  }
}
