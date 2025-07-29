import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/interfaces/body_request.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/header_request.dart';
import '../../../../core/services/logger_service.dart';
import '../../../../core/services/manager_authorization_service.dart';
import '../../../../core/services/paths_service.dart';
import '../../data/datasources/product_datasource.dart';
import '../../domain/models/product_model.dart';
import '../../domain/repository/product_repository.dart';

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
      //TODO Asigne la url del API o recurso para adicionar
      String url = "Url to add";
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

  Future<Stream<Either<Failure, ProductModelType>>> asStreamModel(
      Future<Either<Failure, ProductModelType>> response) async {
    final stream = Stream.fromFuture(response);
    return stream;
  }

  Future<Stream<Either<Failure, EntityModelList<ProductModelType>>>>
      asStreamModelList(
          Future<Either<Failure, EntityModelList<ProductModelType>>>
              response) async {
    final stream = Stream.fromFuture(response);
    return stream;
  }

  @override
  DataSource buildDataSource(String path) => _buildDataSource(path);

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
    final mas = ManagerAuthorizationService().get(PathsService.identityKey);
    if (mas != null) {
      buildDataSource(PathsService.productUrlService);

      // var params = filters as EntityModelList<ProductModelType>;

      log("PARAMS>>>>>>>>>>>>>>>>>$filters");

      var products = await (datasource as RemoteProductDataSourceImpl)
          .filter<EntityModelList<ProductModelType>>(filters);
      return products.fold((l) => Left(ServerFailure(message: l.toString())),
          (products) async {
        log("ESTOS SON LOS PRODUCTOS TRAIDOS EN PRODUCTS REPOSITORY IMPL>>>>>>>>>>>>>>>$products");
        // var tmp =
        //     await LocalSecureStorage.storage.existsOnSecureStorage("account");
        // if (tmp.toString() == "false") {
        //   await LocalSecureStorage.storage
        //       .write("account", accountModelToJson(account));

        //   log("DEBE HABER EMPEZADO A ESCRIBIR");
        // }

        return Right(products);
      });
    }
    return Left(NulleableFailure(
        message: "La instancia de ManagerAuthorizationService es nula."));

    // try {
    //   //TODO Asigne la url del API o recurso para adicionar
    //   String url = "Url to get by field";
    //   //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
    //   BodyRequest body = EmptyBodyRequest();
    //   //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
    //   HeaderRequest header = HeaderRequestImpl(
    //     idpKey: "apiez",
    //   );
    //   buildDataSource(url);
    //   final products = await datasource!.request(url, body, header);
    //   return Right(products);
    // } on ServerException {
    //   return Left(ServerFailure(message: 'Error !!!'));
    // }
  }

  @override
  Future<Either<Failure, ProductModelType>> get(dynamic entityId) async {
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
      final product = await datasource!.request(url, body, header);
      return Right(product);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<ProductModelType>>> getAll() async {
    try {
      String url = "https://apiez.enzona.net/";

      buildDataSource(url);
      final products = await datasource!.getAll();
      return products.fold(
          (l) => Left(ServerFailure(message: l.toString())), (r) => Right(r));
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<ProductModelType>>> getBy(
      Map params) async {
    try {
      final productList = await datasource!.getAll();

      FutureOr<Either<Failure, EntityModelList<ProductModelType>>> process(
          EntityModelList<ProductModelType> list) {
        EntityModelList<ProductModelType> listToReturn =
            DefaultEntityModelList<ProductModelType>();
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

      return productList.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) => process(r.product));
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
      //TODO Asigne la url del API o recurso para adicionar
      String url = "Url to update";
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

  DataSource _buildDataSource(String path) {
    path = path.toLowerCase();

    RegExp remoteRegExp = RegExp(
      r'^(http)|(https)|(ftp)|(ftps)|(ws)|(wss)]|(mms)$',
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
