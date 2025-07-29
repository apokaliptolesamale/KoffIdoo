import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/interfaces/body_request.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/get_provider.dart';
import '../../../../core/interfaces/header_request.dart';
import '../../../product/domain/models/product_model.dart';
import '../providers/product_provider.dart';

/// Implementación de la interfaz de fuente de datos local: LocalDataSource
class LocalProductDataSourceImpl implements LocalDataSource {
  final http.Client client = Get.find();

  LocalProductDataSourceImpl();

  @override
  ProductProvider get getProvider => Get.find();

  @override
  Future<Either<Exception, TModel>> addEntity<TModel>(TModel card) {
    return getProvider.addEntity(card);
  }

  @override
  Future<Either<Exception, TModel>> deleteEntity<TModel>(id) {
    return getProvider.deleteEntity(id);
  }

  @override
  Future<Either<Exception, TList>> filter<TList>(Map<String, dynamic> filters) {
    return getProvider.filter(filters);
  }

  @override
  Future<Either<Exception, TList>> getAll<TList>() {
    return getProvider.getAll();
  }

  @override
  Future<Either<Exception, TList>> getBy<TList>(Map params) {
    return getProvider.getBy<TList>(params);
  }

  @override
  Future<Either<Exception, TModel>> getEntity<TModel>(id) {
    return getProvider.getEntity(id);
  }

  ProductModel getModelFromJson(String data) {
    return productModelFromJson(data);
  }

  @override
  Future<Either<Exception, TList>> paginate<TList>(
      int start, int limit, params) {
    return getProvider.paginate(start, limit, params);
  }

  @override
  Future<ProductModel> request(
      String url, BodyRequest? body, HeaderRequest? header) async {
    final uri = Uri.parse(url);
    final requestBody = body!.getBody();
    final requestHeaders = header!.headersRequest;
    final response = await http.post(
      uri,
      body: requestBody,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      return getModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }

  Future<ProductList> requestProducts(String url) {
    final content = _readFileAsync(url);
    return Future.value(productListModelFromJson(content));
  }

  @override
  DataSource setProvider(GetProviderImpl provider) {
    Get.lazyReplace(() => provider);
    return this;
  }

  @override
  Future<Either<Exception, TModel>> updateEntity<TModel>(
      dynamic id, TModel data) {
    return getProvider.updateEntity(id, data);
  }

  _readFileAsync(
    String path, {
    cache = true,
  }) {
    return rootBundle.loadString(
      path,
      cache: cache,
    );
  }
}

/// Implementación de la interfaz de fuente de datos remota: RemoteDataSource

class RemoteProductDataSourceImpl implements RemoteDataSource {
  final http.Client client = Get.find();

  RemoteProductDataSourceImpl();

  @override
  ProductProvider get getProvider => Get.find();

  @override
  Future<Either<Exception, TModel>> addEntity<TModel>(TModel card) {
    return getProvider.addEntity(card);
  }

  Future<Either<Exception, TModel>> checkEntity<TModel>(id) {
    return getProvider.checkEntity(id);
  }

  @override
  Future<Either<Exception, TModel>> deleteEntity<TModel>(id) {
    return getProvider.deleteEntity(id);
  }

  @override
  Future<Either<Exception, TList>> filter<TList>(Map<String, dynamic> filters) {
    return getProvider.filter(filters);
  }

  @override
  Future<Either<Exception, TList>> getAll<TList>() {
    return getProvider.getAll();
  }

  @override
  Future<Either<Exception, TList>> getBy<TList>(Map params) {
    return getProvider.getBy(params);
  }

  @override
  Future<Either<Exception, TModel>> getEntity<TModel>(id) {
    return getProvider.getEntity(id);
  }

  ProductModel getModelFromJson(String data) {
    return productModelFromJson(data);
  }

  @override
  Future<Either<Exception, TList>> paginate<TList>(
      int start, int limit, params) {
    return getProvider.paginate(start, limit, params);
  }

  @override
  Future<ProductModel> request(
      String url, BodyRequest? body, HeaderRequest? header) async {
    final uri = Uri.parse(url);
    final requestBody = body!.getBody();
    final requestHeaders = header!.headersRequest;
    final response = await http.post(
      uri,
      body: requestBody,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      return getModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  DataSource setProvider(GetProviderImpl provider) {
    Get.lazyReplace(() => provider);
    return this;
  }

  @override
  Future<Either<Exception, TModel>> updateEntity<TModel>(
      dynamic id, TModel data) {
    return getProvider.updateEntity(id, data);
  }
}
