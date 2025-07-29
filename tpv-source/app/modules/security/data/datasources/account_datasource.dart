import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/interfaces/body_request.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/get_provider.dart';
import '../../../../core/interfaces/header_request.dart';
import '../../domain/models/account_model.dart';
import '../providers/account_provider.dart';

/// Implementación de la interfaz de fuente de datos local: LocalDataSource
class LocalAccountDataSourceImpl implements LocalDataSource {
  final http.Client client = Get.find();

  LocalAccountDataSourceImpl();

  @override
  AccountProvider get getProvider => Get.find();

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
    // TODO: implement getEntity
    throw UnimplementedError();
  }

  AccountModel getModelFromJson(String data) {
    return accountModelFromJson(data);
  }

  @override
  Future<Either<Exception, TList>> paginate<TList>(
      int start, int limit, params) async {
    return getProvider.paginate(start, limit, params);
  }

  @override
  Future<AccountModel> request(
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

  Future<AccountList> requestAccounts(String url) async {
    final content = _readFileAsync(url);
    return Future.value(accountListModelFromJson(content));
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

class RemoteAccountDataSourceImpl implements RemoteDataSource {
  final http.Client client = Get.find();

  RemoteAccountDataSourceImpl();

  @override
  AccountProvider get getProvider => Get.find();

  @override
  Future<Either<Exception, TModel>> addEntity<TModel>(TModel entity) async {
    return getProvider.addEntity(entity);
  }

  Future<Either<Exception, TModel>> changePasswordAccount<TModel>(
      dynamic id, Map<String, dynamic> entity) {
    return getProvider.changePasswordAccount(id, entity);
  }

  @override
  Future<Either<Exception, TModel>> deleteEntity<TModel>(id) async {
    return getProvider.deleteEntity(id);
  }

  // Future<Either<Exception, String>> disableToTPCode() async {
  //   return getProvider.disableToTPCode();
  // }

  Future<Either<Exception, TModel>> editAccount<TModel>(
      String url, Map<String, dynamic> accountModel) async {
    return getProvider.editAccount(url, accountModel);
  }

  Future<Either<Exception, TModel>> editAccountPassword<TModel>(
      String url, String newPassword, String oldPassword) async {
    return getProvider.editAccountPassword(url, newPassword, oldPassword);
  }

  Future<Either<Exception, String>> enviarCodigoVerifPhone(String code) async {
    return getProvider.enviarCodigoVerifPhone(code);
  }

  @override
  Future<Either<Exception, TList>> filter<TList>(
      Map<String, dynamic> filters) async {
    return getProvider.filter(filters);
  }

  Future<Either<Exception, String>> generarCodigoVerifPhone() async {
    return getProvider.generarCodigoVerifPhone();
  }

  Future<Either<Exception, TModel>> getAccount<TModel>(String params) async {
    return await getProvider.getAccount(params);
  }

  @override
  Future<Either<Exception, TList>> getAll<TList>() async {
    return getProvider.getAll();
  }

  @override
  Future<Either<Exception, TList>> getBy<TList>(Map params) async {
    return getProvider.getBy(params);
  }

  Future<Either<Exception, TModel>> getDestinatarios<TModel>(
      Map<String, dynamic> entity) {
    return getProvider.getDestinatarios(entity);
  }

  Future<Either<Exception, TModel>> getDisableTotp<TModel>() async {
    return await getProvider.getDisableTotp();
  }

  @override
  Future<Either<Exception, TModel>> getEntity<TModel>(dynamic id) {
    // TODO: implement getEntity
    throw UnimplementedError();
  }

  AccountModel getModelFromJson(String data) {
    return accountModelFromJson(data);
  }

  Future<Either<Exception, TModel>> getRefreshTotp<TModel>() async {
    return await getProvider.getRefreshTotp();
  }

  Future<Either<Exception, TModel>> getTotp<TModel>() async {
    return await getProvider.getTotp();
  }

  Future<Either<Exception, TModel>> getVerifyTotp<TModel>(
      dynamic entity) async {
    return await getProvider.getVerifyTotp(entity);
  }

  @override
  Future<Either<Exception, TList>> paginate<TList>(
      int start, int limit, params) async {
    return getProvider.paginate(start, limit, params);
  }

  @override
  Future<AccountModel> request(
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

  Future<Either<Exception, TModel>> resetPaymentPassword<TModel>(
      dynamic id, Map<String, dynamic> entity) {
    return getProvider.resetPaymentPassword(id, entity);
  }

  @override
  DataSource setProvider(GetProviderImpl provider) {
    Get.lazyReplace(() => provider);
    return this;
  }

  // Future<Either<Exception, Map<String, dynamic>>>
  //     resetPaymentPassword(
  //   String fundingSourceUuid,
  //   String cadenaEncript,
  //   String? cm,
  // ) {
  //   return getProvider.resetPaymentPassword(
  //       fundingSourceUuid, cadenaEncript, cm);
  // }

  @override
  Future<Either<Exception, TModel>> updateEntity<TModel>(
      dynamic id, TModel data) async {
    return getProvider.updateEntity(id, data);
  }

  Future<Either<Exception, TModel>> updatePaymentPassword<TModel>(
      String url, Map<String, dynamic> data) async {
    return getProvider.updatePaymentPassword(url, data);
  }

  Future<Either<Exception, bool>> verificarCodigoVerifPhone(String code) async {
    return getProvider.verificarCodigoVerifPhone(code);
  }

  // Future<Either<Exception, String>> verificarToTPCode(
  //     String text) async {
  //   return getProvider.verificarToTPCode(text);
  // }
}
