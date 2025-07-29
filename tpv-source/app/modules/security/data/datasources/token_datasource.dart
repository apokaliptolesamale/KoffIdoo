import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/interfaces/body_request.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/get_provider.dart';
import '../../../../core/interfaces/header_request.dart';
import '../../domain/models/user_model.dart';
import '../providers/token_provider.dart';

class LocalTokenDataSourceImpl implements LocalDataSource {
  final http.Client client = Get.find();

  LocalTokenDataSourceImpl();

  @override
  TokenProvider get getProvider => Get.find();

  @override
  DataSource setProvider(GetProviderImpl provider) {
    Get.lazyReplace(() => provider);
    return this;
  }

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
    return getProvider.getBy(params);
  }

  @override
  Future<Either<Exception, TModel>> getEntity<TModel>(id) {
    // TODO: implement getEntity
    throw UnimplementedError();
  }

  UserModel getUserFromJson(String data) {
    return UserModel.fromJson(json.decode(data));
  }

  @override
  Future<Either<Exception, TList>> paginate<TList>(
      int start, int limit, params) {
    return getProvider.paginate(start, limit, params);
  }

  @override
  Future<UserModel> request(
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
      return getUserFromJson(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Either<Exception, TModel>> updateEntity<TModel>(
      dynamic id, TModel data) {
    return getProvider.updateEntity(id, data);
  }
}

class RemoteTokenDataSourceImpl implements RemoteDataSource {
  final http.Client client = Get.find();

  RemoteTokenDataSourceImpl();

  @override
  TokenProvider get getProvider => Get.find();

  @override
  DataSource setProvider(GetProviderImpl provider) {
    Get.lazyReplace(() => provider);
    return this;
  }

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
    return getProvider.getBy(params);
  }

  @override
  Future<Either<Exception, TModel>> getEntity<TModel>(id) {
    // TODO: implement getEntity
    throw UnimplementedError();
  }

  UserModel getUserFromJson(String data) {
    return UserModel.fromJson(json.decode(data));
  }

  @override
  Future<Either<Exception, TList>> paginate<TList>(
      int start, int limit, params) {
    return getProvider.paginate(start, limit, params);
  }

  @override
  Future<UserModel> request(
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
      return getUserFromJson(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Either<Exception, TModel>> updateEntity<TModel>(
      dynamic id, TModel data) {
    return getProvider.updateEntity(id, data);
  }
}
