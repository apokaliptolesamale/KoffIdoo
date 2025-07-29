// ignore_for_file: unused_element

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '/app/core/helpers/functions.dart';
import '/app/core/interfaces/header_request.dart';
import '/app/core/services/logger_service.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/config/errors/fault.dart';
import '../../../../core/interfaces/get_provider.dart';
import '../../domain/models/design_model.dart';

class DesignProvider extends GetProviderImpl {
  @override
  Future<Either<Exception, TModel>> addEntity<TModel>(TModel entity) async {
    log("Adicionando nueva entidad de tipo:DesignModel.");
    Map<String, dynamic> data = {};
    if (entity is DesignModel) {
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
          return DesignModel.fromJson(map);
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
          return DesignModel.fromJson(map);
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
    log("Cargando listado de bancos...");
    filters.removeWhere((key, value) => value == null);
    String url = '';
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      idpKey: "apiez",
    ).getHeaders();
    final query = getShemaQueryFromMap(filters);
    final response = await processResponse(get(
      "$url?$query",
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          return DesignModel.fromJson(map);
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
    log("Cargando listado de entidades...");
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
          return DesignModel.fromJson(map);
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
              "message": "Error al consultar listado de entidades.",
              "description": "Error al consultar listado de entidades."
            }));
      }
    });
  }

  @override
  Future<Either<Exception, TList>> getBy<TList>(Map params) async {
    //Map<String, String> headers = getHeader();
    // TODO: implement paginate
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, TModel>> getEntity<TModel>(dynamic id) async {
    log("Cargando entidad de tipo 'Design' con identificador=$id");
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
          return DesignModel.fromJson(map);
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
            ? DesignList.fromJson(map)
            : DesignList.fromJson(map);
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
  DesignProvider setBaseUrl(String newBaseUrl) {
    super.setBaseUrl(httpClient.baseUrl = baseUrl = newBaseUrl);
    return this;
  }

  @override
  Future<Either<Exception, TModel>> updateEntity<TModel>(
      dynamic id, TModel data) async {
    log("Cargando entidad de tipo 'Design' con identificador=$id");
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
          return DesignModel.fromJson(map);
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
