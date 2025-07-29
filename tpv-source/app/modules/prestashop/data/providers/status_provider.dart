import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '/app/core/services/logger_service.dart';
import '/app/modules/prestashop/service/query.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/config/errors/fault.dart';
import '../../../../core/interfaces/get_provider.dart';
import '../../domain/models/status_model.dart';

class StatusProvider extends GetProviderImpl {
  @override
  Future<Either<Exception, TModel>> addEntity<TModel>(TModel entity) async {
    // TODO: implement addEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, TModel>> deleteEntity<TModel>(id) async {
    // TODO: implement deleteEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, TList>> filter<TList>(
      Map<String, dynamic> filters) async {
    // TODO: implement filter
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, TList>> getAll<TList>() async {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, TList>> getBy<TList>(Map params) async {
    final datos = params;
    datos.removeWhere((key, value) => value == null);
    List<Where<Object, Map<String, Object>>> filters = [
      Where(key: params['field'], value: params['value'])
    ];

    PrestaShopQuery query = PrestaShopQuery(
      tableName: "order_states",
      filters: filters,
      // offSet: 0,
      // limit: 1,
    );
    String url = query.queryService();

    try {
      log("Url service: $baseUrl$url.");
      onStatusCodeListener(401, (provider, response, code) async {
        log("Probando manejo de CallBack para StatusCode=$code");
        return provider;
      }).onStatusCodeListener(204, (provider, response, code) async {
        log("Probando manejo de CallBack para StatusCode=$code");
        return provider;
      }).onStatusCodeListener(500, (provider, response, code) async {
        log("Probando manejo de CallBack para StatusCode=$code");
        return provider;
      });

      final response = await processResponse(
        get(
          url,
          decoder: defaultDecoder,
        ),
        provider: this,
      );

      return response.fold((l) => Left(l), (resp) {
        if (resp.body is StatusList) {
          return Right(resp.body);
        } else {
          if (resp.body is Map<String, dynamic> &&
              !resp.body.containsKey("fault")) {
            return Right(StatusList.fromJson(resp.body) as TList);
          } else if (resp.body is Map<String, dynamic> &&
              resp.body.containsKey("fault")) {
            return Left(HttpServerException(
              fault: Fault.fromJson(resp.body['fault']),
            ));
          } else if (resp.body
              .toString()
              .startsWith("<?xml version=\"1.0\" encoding=\"UTF-8\"?>")) {
            return Right(StatusList.fromXml(resp.body) as TList);
          }
        }
        return Right(StatusList.fromJson({}) as TList);
      });
    } on SocketException {
      throw HttpServerException(
          fault: Fault.fromJson({
        "code": "500",
        "type": "Error",
        "message": "Ocurrió un error de tipo: SocketException.",
        "description":
            "El error de tipo SocketException ocurre cuando no existe conexión disponible entre el cliente y el servidor:${Uri.parse(url).host}."
      }));
    }
  }

  @override
  void onInit() {
    defaultDecoder = httpClient.defaultDecoder = super.defaultDecoder = (map) {
      if (map is Map<String, dynamic> && !map.containsKey("fault")) {
        return StatusList.fromJson(map);
      } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
        return Fault.fromJson(map['fault']);
      } else if (map
          .toString()
          .startsWith("<?xml version=\"1.0\" encoding=\"UTF-8\"?>")) {
        return StatusList.fromXml(map);
      }
    };
    //httpClient.baseUrl = 'YOUR-API-URL';
  }

  @override
  Future<Either<Exception, TList>> paginate<TList>(
      int start, int limit, params) async {
    // TODO: implement paginate
    throw UnimplementedError();
  }

  @override
  StatusProvider setBaseUrl(String newBaseUrl) {
    super.setBaseUrl(httpClient.baseUrl = baseUrl = newBaseUrl);
    return this;
  }

  @override
  Future<Either<Exception, TModel>> updateEntity<TModel>(
      dynamic id, TModel data) async {
    // TODO: implement updateEntity
    throw UnimplementedError();
  }

  _readFileAsync(String path) async {
    return await rootBundle.loadString(path);
  }
}
