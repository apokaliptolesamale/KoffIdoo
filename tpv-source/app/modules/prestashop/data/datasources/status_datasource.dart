import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/interfaces/body_request.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/get_provider.dart';
import '../../../../core/interfaces/header_request.dart';
import '../../domain/models/status_model.dart';
import '../providers/status_provider.dart';

/// Implementación de la interfaz de fuente de datos local: LocalDataSource
class LocalStatusDataSourceImpl implements LocalDataSource {
  final http.Client client = Get.find();

  LocalStatusDataSourceImpl();

  @override
  StatusProvider get getProvider => Get.find();

  @override
  Future<Either<Exception, TModel>> addEntity<TModel>(TModel entity) async {
    return getProvider.addEntity(entity);
  }

  @override
  Future<Either<Exception, TModel>> deleteEntity<TModel>(id) async {
    return getProvider.deleteEntity(id);
  }

  @override
  Future<Either<Exception, TList>> filter<TList>(
      Map<String, dynamic> filters) async {
    return getProvider.filter(filters);
  }

  @override
  Future<Either<Exception, TList>> getAll<TList>() async {
    return getProvider.getAll();
  }

  @override
  Future<Either<Exception, TList>> getBy<TList>(Map params) async {
    return getProvider.getBy(params);
  }

  @override
  Future<Either<Exception, TModel>> getEntity<TModel>(id) {
    // TODO: implement getEntity
    throw UnimplementedError();
  }

  StatusModel getModelFromJson(String data) {
    return statusModelFromJson(data);
  }

  @override
  Future<Either<Exception, TList>> paginate<TList>(
      int start, int limit, params) async {
    return getProvider.paginate(start, limit, params);
  }

  @override
  Future<StatusModel> request(
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

  Future<StatusList> requestStatuss(String url) async {
    final content = _readFileAsync(url);
    return Future.value(statusListModelFromJson(content));
  }

  @override
  DataSource setProvider(GetProviderImpl provider) {
    Get.lazyReplace(() => provider);
    return this;
  }

  @override
  Future<Either<Exception, TModel>> updateEntity<TModel>(
      dynamic id, TModel data) async {
    return getProvider.updateEntity(id, data);
  }

  _readFileAsync(String path) async {
    return await rootBundle.loadString(path);
  }
}

/// Implementación de la interfaz de fuente de datos remota: RemoteDataSource

class RemoteStatusDataSourceImpl implements RemoteDataSource {
  final http.Client client = Get.find();

  RemoteStatusDataSourceImpl();

  @override
  StatusProvider get getProvider => Get.find();

  @override
  Future<Either<Exception, TModel>> addEntity<TModel>(TModel entity) async {
    return getProvider.addEntity(entity);
  }

  @override
  Future<Either<Exception, TModel>> deleteEntity<TModel>(id) async {
    return getProvider.deleteEntity(id);
  }

  @override
  Future<Either<Exception, TList>> filter<TList>(
      Map<String, dynamic> filters) async {
    return getProvider.filter(filters);
  }

  @override
  Future<Either<Exception, TList>> getAll<TList>() async {
    return getProvider.getAll();
  }

  @override
  Future<Either<Exception, TList>> getBy<TList>(Map params) async {
    return getProvider.getBy(params);
  }

  @override
  Future<Either<Exception, TModel>> getEntity<TModel>(id) {
    // TODO: implement getEntity
    throw UnimplementedError();
  }

  StatusModel getModelFromJson(String data) {
    return statusModelFromJson(data);
  }

  @override
  Future<Either<Exception, TList>> paginate<TList>(
      int start, int limit, params) async {
    return getProvider.paginate(start, limit, params);
  }

  @override
  Future<StatusModel> request(
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
      dynamic id, TModel data) async {
    return getProvider.updateEntity(id, data);
  }
}
