import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../../../core/config/errors/fault.dart';
import '../../../../core/interfaces/get_provider.dart';
import '../../domain/models/profile_model.dart';

class ProfileProvider extends GetProviderImpl {
  @override
  Future<Either<Exception, TModel>> addEntity<TModel>(TModel entity) async {
    // TODO: implement addEntity
    //Map<String, String> headers = getHeader();
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, TModel>> deleteEntity<TModel>(id) async {
    //Map<String, String> headers = getHeader();
    // TODO: implement deleteEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, TList>> filter<TList>(
      Map<String, dynamic> filters) async {
    ////Map<String, String> headers = getHeader();
    // TODO: implement filter
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, TList>> getAll<TList>() async {
    //Map<String, String> headers = getHeader();
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, TList>> getBy<TList>(Map params) async {
    //Map<String, String> headers = getHeader();
    // TODO: implement paginate
    throw UnimplementedError();
  }

  @override
  void onInit() {
    httpClient.defaultDecoder = defaultDecoder = super.defaultDecoder = (map) {
      if (map is Map<String, dynamic> && !map.containsKey("fault")) {
        return map.containsKey("orders")
            ? ProfileList.fromJson(map)
            : ProfileList.fromJson(map);
      } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
        return Fault.fromJson(map['fault']);
      }
    };
    //httpClient.baseUrl = 'YOUR-API-URL';
  }

  @override
  Future<Either<Exception, TList>> paginate<TList>(
      int start, int limit, params) async {
    //Map<String, String> headers = getHeader();
    // TODO: implement paginate
    throw UnimplementedError();
  }

  @override
  ProfileProvider setBaseUrl(String newBaseUrl) {
    super.setBaseUrl(httpClient.baseUrl = baseUrl = newBaseUrl);
    return this;
  }

  @override
  Future<Either<Exception, TModel>> updateEntity<TModel>(
      dynamic id, TModel data) async {
    //Map<String, String> headers = getHeader();
    // TODO: implement updateEntity
    throw UnimplementedError();
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
