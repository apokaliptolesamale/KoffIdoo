// ignore_for_file: unused_element

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '/app/core/interfaces/header_request.dart';
import '/app/core/services/logger_service.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/config/errors/fault.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/interfaces/get_provider.dart';
import '../../domain/models/category_model.dart';
import '../../domain/models/gift_model.dart';

class CategoryProvider extends GetProviderImpl {
  @override
  Future<Either<Exception, TModel>> addEntity<TModel>(TModel entity) async {
    log("Adicionando nueva entidad de tipo:GiftModel.");
    Map<String, dynamic> data = {};
    if (entity is GiftModel) {
      data = entity.toJson();
    } else if (entity is Map<String, dynamic>) {
      data = entity;
    }
    String url = '';
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      idpKey: "apiez",
    ).getHeaders();

    final response = await processResponse(post(
      url,
      data,
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          return GiftModel.fromJson(map);
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },
    ));
    return response.fold((l) => Left(l), (resp) {
      if (resp.statusCode == 200) {
        return Right(resp.body);
      } else {
        throw HttpServerException(
            response: resp,
            fault: Fault.fromJson({
              "code": resp.statusCode,
              "type": "Error",
              "message": "Error al filtrar listado.",
              "description": "Error al filtrar listado."
            }));
      }
    });
  }

  @override
  Future<Either<Exception, TModel>> deleteEntity<TModel>(id) async {
    log("Eliminando entidad con identificador=$id.");

    String url = '';
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      idpKey: "apiez",
    ).getHeaders();

    final response = await processResponse(delete(
      url,
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          return GiftModel.fromJson(map);
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },
    ));
    return response.fold((l) => Left(l), (resp) {
      if (resp.statusCode == 200) {
        return Right(resp.body);
      } else {
        throw HttpServerException(
            response: resp,
            fault: Fault.fromJson({
              "code": resp.statusCode,
              "type": "Error",
              "message": "Error al filtrar listado.",
              "description": "Error al filtrar listado."
            }));
      }
    });
  }

  @override
  Future<Either<Exception, TList>> filter<TList>(
      Map<String, dynamic> filters) async {
    log("Cargando listado de operaciones...");
    var value = filters.values;
    var id = value.first;
    log('Este es el id ==> $id');
    log('Este es el mapa del query para filtrar ==> $filters'); //filters.removeWhere((key, value) => value == null);
    String url = '/giftapi/v1.0.0/gift/$id/category';
    log('Esta es la url con el foundingSource ==> $url');
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {
        "accept": "application/json",
        "Version": Constants.versionApk,
      },
      idpKey: "identity",
    ).getHeaders(accesToken: true);
    //final query = getShemaQueryFromMap(filters); bh
    final response = await processResponse(get(
      url,
      //query: id, //"$url?$query",
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> &&
            !map.containsKey("fault") &&
            map.containsKey("gift") &&
            map.containsKey("avatars")) {
          log('Regalos => $map');
          //log('Lo q vienen coordenadas => ${OperationList.fromJson(map["operations"])}');
          if (map["gift"].toString().contains('[')) {
            log('Esto contiene parentesis es una lista ==> ${map["gift"].toString()}');
          } else {
            log(map.values.last.toString());
            Map<String, dynamic> mapa = map.values.last;
            List<Map<String, dynamic>> list = [];
            list.add(mapa);
            //var map2 = map.entries.last;
            map.forEach(
              (key, value) {
                if (key == "gift") {
                  value = list;
                  map.update(key, (value) => [value]);
                }
              },
            );
            /* map.updateAll((key, value) => {
              "avatars": value,
              "gift": list});  */
            log('Este es list==> $list');
            log('Asi queda el map ==> ${map.toString()}');
          }
          return GiftList.fromJson(map);
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },
    ));
    return response.fold((l) => Left(l), (resp) {
      if (resp.statusCode == 200) {
        return Right(resp.body);
      } else {
        throw HttpServerException(
            response: resp,
            fault: Fault.fromJson({
              "code": resp.statusCode,
              "type": "Error",
              "message": "Error al filtrar listado.",
              "description": "Error al filtrar listado."
            }));
      }
    });
  }

  @override
  Future<Either<Exception, TList>> getAll<TList>() async {
    log("Cargando listado de catergorias de regalos...");
    String url = '/giftapi/v1.0.0/gift/category';
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {
        "accept": "application/json",
        "Version": Constants.versionApk,
      },
      idpKey: "identity",
    ).getHeaders(accesToken: true);

    final response = await processResponse(get(
      url,
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> &&
            !map.containsKey("fault") &&
            map.containsKey("category")) {
          log('Lo q vieneneidnfoenofainfoiafidnswcofnawdef => $map');

          return CategoryList.fromJson(map);
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },
    ));
    return response.fold((l) => Left(l), (resp) {
      if (resp.statusCode == 200) {
        log('Este es el Cardddd=> ${resp.body}');
        log('Este es el StatusCode de Cards=> ${resp.statusCode}');
        log('Este es el Status Text de card=>${resp.statusText}');
        return Right(resp.body);
      } else {
        throw HttpServerException(
            response: resp,
            fault: Fault.fromJson({
              "code": resp.statusCode,
              "type": "Error",
              "message": "Error al consultar listado de entidades.",
              "description": "Error al consultar listado de entidades."
            }));
      }
    });
  }

  @override
  Future<Either<Exception, TList>> getBy<TList>(Map params) async {
    Map<String, String> headers = getHeader();
    // TODO: implement paginate
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, TModel>> getEntity<TModel>(dynamic id) async {
    log("Cargando entidad de tipo 'Gift' con identificador=$id");
    String url = '';
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      idpKey: "apiez",
    ).getHeaders();

    final response = await processResponse(get(
      url,
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          return GiftModel.fromJson(map);
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },
    ));
    return response.fold((l) => Left(l), (resp) {
      if (resp.statusCode == 200) {
        return Right(resp.body);
      } else {
        throw HttpServerException(
            response: resp,
            fault: Fault.fromJson({
              "code": resp.statusCode,
              "type": "Error",
              "message":
                  "Error al intentar obtener entidad con identificador=$id, contacte al administrador.",
              "description":
                  "Error al intentar obtener entidad con identificador=$id, contacte al administrador."
            }));
      }
    });
  }

  @override
  void onInit() {
    httpClient.defaultDecoder = defaultDecoder = super.defaultDecoder = (map) {
      if (map is Map<String, dynamic> && !map.containsKey("fault")) {
        return map.containsKey("orders")
            ? CategoryList.fromJson(map)
            : CategoryList.fromJson(map);
      } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
        return Fault.fromJson(map['fault']);
      }
    };
    //httpClient.baseUrl = 'YOUR-API-URL';
  }

  @override
  Future<Either<Exception, TList>> paginate<TList>(
      int start, int limit, params) async {
    Map<String, String> headers = getHeader();
    // TODO: implement paginate
    throw UnimplementedError();
  }

  @override
  setBaseUrl(String baseUrl) => super.setBaseUrl(httpClient.baseUrl = baseUrl);

  @override
  Future<Either<Exception, TModel>> updateEntity<TModel>(
      dynamic id, TModel data) async {
    log("Cargando entidad de tipo 'Gift' con identificador=$id");
    String url = '';
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      idpKey: "apiez",
    ).getHeaders();
    final response = await processResponse(put(
      url,
      data,
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          return GiftModel.fromJson(map);
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },
    ));
    return response.fold((l) => Left(l), (resp) {
      if (resp.statusCode == 200) {
        return Right(resp.body);
      } else {
        throw HttpServerException(
            response: resp,
            fault: Fault.fromJson({
              "code": resp.statusCode,
              "type": "Error",
              "message": "Error al actualizar entidad.",
              "description": "Error al actualizar entidad."
            }));
      }
    });
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
