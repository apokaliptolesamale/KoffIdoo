import 'package:dartz/dartz.dart';
import '/app/modules/transaction/domain/models/invoice_charged_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '/app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/interfaces/body_request.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/get_provider.dart';
import '../../../../core/interfaces/header_request.dart';
import '../../domain/models/invoice_model.dart';
import '../providers/invoice_provider.dart';

/// Implementación de la interfaz de fuente de datos local: LocalDataSource
class LocalInvoiceDataSourceImpl implements LocalDataSource {
  final http.Client client = Get.find();

  LocalInvoiceDataSourceImpl();

  @override
  InvoiceProvider get getProvider => Get.find();

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

  InvoiceModel getModelFromJson(String data) {
    return invoiceModelFromJson(data);
  }

  @override
  Future<Either<Exception, TList>> paginate<TList>(
      int start, int limit, params) async {
    return getProvider.paginate(start, limit, params);
  }

  @override
  Future<InvoiceModel> request(
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

  Future<EntityModelList<InvoiceModel>> requestInvoices(String url) async {
    final content = await rootBundle.loadString(url);
    return Future.value(invoiceListModelFromJson(content));
  }

  Future<InvoiceChargedModel> requestInvoiceCharged(String url) async {
    final content = await rootBundle.loadString(url);
    return Future.value(invoiceChargedModelFromJson(content));
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

class RemoteInvoiceDataSourceImpl implements RemoteDataSource {
  final http.Client client = Get.find();

  RemoteInvoiceDataSourceImpl();

  @override
  InvoiceProvider get getProvider => Get.find();

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

  Future<Either<Exception, TModel>> getCliendId<TModel>(
      Map<String, dynamic> params) async {
    return getProvider.getClientId(params);
  }

  @override
  Future<Either<Exception, TModel>> getEntity<TModel>(dynamic id) {
    return getProvider.getEntity(id);
  }

  InvoiceModel getModelFromJson(String data) {
    return invoiceModelFromJson(data);
  }

  @override
  Future<Either<Exception, TList>> paginate<TList>(
      int start, int limit, params) async {
    return getProvider.paginate(start, limit, params);
  }

   Future<Either<Exception, TModel>> payEletricityService<TModel>( Map<String, dynamic> params) {
    return getProvider.payEletricityService(params);
  }

  Future<Either<Exception, TModel>> getInvoiceByClientId<TModel>(Map<String, dynamic> params) async {
    return getProvider.getInvoiceByClientId( params);
  }

  @override
  Future<InvoiceModel> request(
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
