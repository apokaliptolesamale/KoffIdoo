import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '/app/core/config/errors/fault.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/helpers/functions.dart';
import '../../../../core/interfaces/body_request.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/get_provider.dart';
import '../../../../core/interfaces/header_request.dart';
import '../../domain/models/rbac_model.dart';
import '../providers/rbac_provider.dart';

/// Implementación de la interfaz de fuente de datos local: LocalDataSource
class LocalRbacDataSourceImpl implements LocalDataSource {
  final http.Client client = Get.find();

  LocalRbacDataSourceImpl();

  @override
  RbacProvider get getProvider => Get.find();

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
  Future<Either<Exception, TModel>> getEntity<TModel>(dynamic id) {
    return getProvider.getEntity(id);
  }

  RbacModel getModelFromJson(String data) {
    return rbacModelFromJson(data);
  }

  Future<Either<Exception, TModel>> loadRoles<TModel>(String path) async {
    try {
      final str = await readFromAssetsFile(path);
      final model = RbacModel.fromJson(json.decode(str));
      return Future.value(Right(model as TModel));
    } catch (e) {
      return Future.value(Left(HttpServerException(
        fault: Fault.fromJson({
          "code": "500",
          "type": "error",
          "message": "Error al cargar los roles...",
          "description":
              "Error al cargar los roles desde almacenamiento local.",
        }),
      )));
    }
  }

  @override
  Future<Either<Exception, TList>> paginate<TList>(
      int start, int limit, params) async {
    return getProvider.paginate(start, limit, params);
  }

  @override
  Future<RbacModel> request(
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

  Future<RbacList> requestRbacs(String url) async {
    final content = await _readFileAsync(url);
    return Future.value(rbacListModelFromJson(content));
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

  Future<String> _readFileAsync(
    String path, {
    cache = true,
  }) async {
    return rootBundle.loadString(
      path,
      cache: cache,
    );
  }
}

/// Implementación de la interfaz de fuente de datos remota: RemoteDataSource

class RemoteRbacDataSourceImpl implements RemoteDataSource {
  final http.Client client = Get.find();

  RemoteRbacDataSourceImpl();

  @override
  RbacProvider get getProvider => Get.find();

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
  Future<Either<Exception, TModel>> getEntity<TModel>(dynamic id) {
    return getProvider.getEntity(id);
  }

  RbacModel getModelFromJson(String data) {
    return rbacModelFromJson(data);
  }

  Future<Either<Exception, TModel>> loadRoles<TModel>(String path) async {
    return getProvider.loadRoles(path);
  }

  @override
  Future<Either<Exception, TList>> paginate<TList>(
      int start, int limit, params) async {
    return getProvider.paginate(start, limit, params);
  }

  @override
  Future<RbacModel> request(
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
