import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '/app/core/config/assets.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/config/errors/fault.dart';
import '../../../../core/interfaces/get_provider.dart';
import '../../domain/models/config_model.dart';

class ConfigProvider extends GetProviderImpl {
  @override
  Future<Either<Exception, TModel>> addEntity<TModel>(TModel card) {
    // TODO: implement addEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, TModel>> deleteEntity<TModel>(id) {
    // TODO: implement deleteEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, TList>> filter<TList>(Map<String, dynamic> filters) {
    // TODO: implement filter
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, TList>> getAll<TList>() async {
    try {
      String data = await _readFileAsync(
        baseUrl!,
        cache: false,
      );
      String designData = await _readFileAsync(
        ASSETS_MODELS_DESIGN_JSON,
        cache: false,
      );
      final design = json.decode(designData);
      final tmpData = json.decode(data);
      ((tmpData["configs"] as List).elementAt(0) as Map)["design"] = design;
      //data = json.encode(tmpData);
      //ConfigList list = configListModelFromJson(data);
      return Future.value(Right(configListModelFromJson(tmpData) as TList));
    } on Exception {
      return Future.value(Left(HttpServerException(
          fault: Fault(
        faultCode: 500,
        type: "READ",
        message: "Server internal error",
        description:
            "Ha ocurrido un error al intentar leer el fichero/ruta en:${baseUrl ?? ''}",
      ))));
    }
  }

  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic> && !map.containsKey("fault")) {
        return ConfigList.fromJson(map);
      } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
        return Fault.fromJson(map['fault']);
      }
    };
    //httpClient.baseUrl = 'YOUR-API-URL';
  }

  @override
  Future<Either<Exception, TList>> paginate<TList>(
      int start, int limit, params) {
    // TODO: implement paginate
    throw UnimplementedError();
  }

  @override
  ConfigProvider setBaseUrl(String newBaseUrl) {
    super.setBaseUrl(httpClient.baseUrl = baseUrl = newBaseUrl);
    return this;
  }

  @override
  Future<Either<Exception, TModel>> updateEntity<TModel>(
      dynamic id, TModel data) {
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
