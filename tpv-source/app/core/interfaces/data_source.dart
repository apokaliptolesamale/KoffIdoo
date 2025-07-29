import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import 'body_request.dart';
import 'get_provider.dart';
import 'header_request.dart';

abstract class DataSource<Model> {
  GetProviderImpl get getProvider => Get.find<GetProviderImpl>();

  Future<Either<Exception, TModel>> addEntity<TModel>(TModel entity);

  Future<Either<Exception, TModel>> deleteEntity<TModel>(id);

  Future<Either<Exception, TList>> filter<TList>(Map<String, dynamic> filters);

  Future<Either<Exception, TList>> getAll<TList>();

  Future<Either<Exception, TList>> getBy<TList>(Map params);

  Future<Either<Exception, TModel>> getEntity<TModel>(dynamic id);

  Future<Either<Exception, TList>> paginate<TList>(
      int start, int limit, params);

  Future<Model> request(String url, BodyRequest? body, HeaderRequest? header);

  DataSource<Model> setProvider(GetProviderImpl provider);

  Future<Either<Exception, TModel>> updateEntity<TModel>(
      dynamic id, TModel data);
}

abstract class LocalDataSource<Model> extends DataSource {
  @override
  GetProviderImpl get getProvider => Get.find<GetProviderImpl>();

  @override
  Future<Either<Exception, TModel>> addEntity<TModel>(TModel entity);

  @override
  Future<Either<Exception, TModel>> deleteEntity<TModel>(id);

  @override
  Future<Either<Exception, TList>> filter<TList>(Map<String, dynamic> filters);

  @override
  Future<Either<Exception, TList>> getAll<TList>();

  @override
  Future<Either<Exception, TList>> getBy<TList>(Map params);

  @override
  Future<Either<Exception, TModel>> getEntity<TModel>(dynamic id);

  @override
  Future<Either<Exception, TList>> paginate<TList>(
      int start, int limit, params);

  @override
  Future<Model> request(String url, BodyRequest? body, HeaderRequest? header);
  @override
  Future<Either<Exception, TModel>> updateEntity<TModel>(
      dynamic id, TModel data);
}

abstract class RemoteDataSource<Model> extends DataSource {
  @override
  GetProviderImpl get getProvider => Get.find<GetProviderImpl>();

  @override
  Future<Either<Exception, TModel>> addEntity<TModel>(TModel entity);

  @override
  Future<Either<Exception, TModel>> deleteEntity<TModel>(id);

  @override
  Future<Either<Exception, TList>> filter<TList>(Map<String, dynamic> filters);

  @override
  Future<Either<Exception, TList>> getAll<TList>();

  @override
  Future<Either<Exception, TList>> getBy<TList>(Map params);

  @override
  Future<Either<Exception, TModel>> getEntity<TModel>(dynamic id);

  @override
  Future<Either<Exception, TList>> paginate<TList>(
      int start, int limit, params);

  @override
  Future<Model> request(String url, BodyRequest? body, HeaderRequest? header);
  @override
  Future<Either<Exception, TModel>> updateEntity<TModel>(
      dynamic id, TModel data);
}
