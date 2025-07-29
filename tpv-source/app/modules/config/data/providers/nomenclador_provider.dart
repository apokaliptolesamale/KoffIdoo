// ignore_for_file: unused_element

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '/app/core/config/assets.dart';
import '/app/core/helpers/functions.dart';
import '/app/core/interfaces/entity_model.dart';
import '/app/core/interfaces/header_request.dart';
import '/app/core/services/logger_service.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/config/errors/fault.dart';
import '../../../../core/interfaces/get_provider.dart';
import '../../domain/models/nomenclador_model.dart';

class NomencladorProvider extends GetProviderImpl {
  @override
  Future<Either<Exception, TModel>> addEntity<TModel>(TModel entity) async {
    log("Adicionando nueva entidad de tipo:NomencladorModel.");
    Map<String, dynamic> data = {};
    if (entity is NomencladorModel) {
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
          return NomencladorModel.fromJson(map);
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
          return NomencladorModel.fromJson(map);
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
    log("Filtro de nomencladores en $baseUrl");
    filters.removeWhere((key, value) => value == null);
    final query = getShemaQueryFromMap(filters);
    String url = "nomenclators/filter?$query";
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      idpKey: "apiez",
    ).getHeaders();
    //setBaseUrl(PathsService.nomUrlService);
    //final query = getShemaQueryFromMap(filters);

    final response = await processResponse(get(
      url,
      headers: headers,
      decoder: (map) {
        if (map is List) {
          final list = map;
          if (list.isNotEmpty) {
            return NomencladorList.fromJson(list.first);
          }
          throw EmptyResposeException();
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },
    ));
    return response.fold((l) {
      return Left(l);
    }, (resp) {
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
          return NomencladorModel.fromJson(map);
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
    ////Map<String, String> headers = getHeader();
    // TODO: implement paginate
    throw UnimplementedError();
  }

  Future<Either<Exception, TList>> getComercialsUnitsFromAssets<TList>() async {
    log("Cargando listado de entidades...");
    try {
      final list = getTrdUnitsFromAssets();
      return Future.value(Right(list as TList));
    } catch (e) {
      return Future.value(Left(HttpServerException(
          fault: Fault.fromJson({
        "code": "00",
        "type": "Error",
        "message": "Error al consultar listado de entidades.",
        "description": "Error al consultar listado de entidades.",
      }))));
    }

    /*String url = '';
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
          return NomencladorModel.fromJson(map);
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
    });*/
  }

  Future<Either<Exception, TList>> getComercialUnits<TList>() async {
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
          return NomencladorModel.fromJson(map);
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
  Future<Either<Exception, TModel>> getEntity<TModel>(dynamic id) async {
    log("Cargando entidad de tipo 'Nomenclador' con identificador=$id");
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
          return NomencladorModel.fromJson(map);
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

  Future<Either<Exception, TList>> getNomencladoresByClientId<TList>(
      String clientId) async {
    String url = 'nomenclators/clientId';
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      idpKey: "apiez",
    ).getHeaders();

    final response = await processResponse(get(
      url,
      query: {"clientId": clientId},
      headers: headers,
      decoder: (data) {
        if (data is List) {
          final list = data;
          return list.map((e) => NomencladorModel.fromJson(e));
        }
        return data;
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

  Future<Either<Exception, TList>> getPaymentTypesFromAssets<TList>() async {
    try {
      String contents =
          await readFileFromAssets(ASSETS_MODELS_PAYMENTTYPES_JSON);
      if (contents.isNotEmpty) {
        final list = NomencladorList.customReaderfromJson(
          json.decode(contents),
          (data) {
            return NomencladorModel(
              idNomenclature: EntityModel.getValueFromJson<String>(
                "idNomenclature",
                data,
                "",
                reader: (key, data, defaultValue) {
                  if (data.containsKey(key)) return data[key].toString();
                  return defaultValue;
                },
                cast: (value) {
                  return value.toString();
                },
              ),
              idPadre: EntityModel.getValueFromJson<String>(
                "idPadre",
                data,
                EntityModel.getValueFromJson<String>(
                  "id",
                  data,
                  "",
                  reader: (key, data, defaultValue) {
                    if (data.containsKey(key)) return data[key].toString();
                    return defaultValue;
                  },
                  cast: (value) {
                    return value.toString();
                  },
                ),
                reader: (key, data, defaultValue) {
                  if (data.containsKey(key)) return data[key].toString();
                  return defaultValue;
                },
                cast: (value) {
                  return value.toString();
                },
              ),
              denomination: EntityModel.getValueFromJson<String>(
                  "denomination", data, ""),
            );
          },
        ) as TList;
        return Future.value(Right(list));
      }
      return Future.value(Right(NomencladorList.fromEmpty() as TList));
    } catch (e) {
      throw HttpServerException(
          response: "000",
          fault: Fault.fromJson({
            "code": "500",
            "type": "Error",
            "message": "Error al listar datos.",
            "description": "Error al listar datos."
          }));
    }
  }

  Future<Either<Exception, TList>> getProvinciasFromAssets<TList>() async {
    try {
      String contents = await readFileFromAssets(ASSETS_MODELS_PROVINCIAS_JSON);
      if (contents.isNotEmpty) {
        final list = NomencladorList.customReaderfromJson(
          json.decode(contents),
          (data) {
            return NomencladorModel(
              idNomenclature: EntityModel.getValueFromJson<String>(
                "idNomenclature",
                data,
                "",
                reader: (key, data, defaultValue) {
                  if (data.containsKey(key)) {
                    return "${data[key]}";
                  }
                  return defaultValue;
                },
              ),
              idPadre: EntityModel.getValueFromJson<String>(
                "idPadre",
                data,
                EntityModel.getValueFromJson<String>(
                  "id",
                  data,
                  "",
                  reader: (key, data, defaultValue) {
                    if (data.containsKey(key)) {
                      return "${data[key]}";
                    }
                    return defaultValue;
                  },
                ),
                reader: (key, data, defaultValue) {
                  if (data.containsKey(key)) {
                    return "${data[key]}";
                  }
                  return defaultValue;
                },
              ),
              denomination:
                  EntityModel.getValueFromJson("denomination", data, ""),
            );
          },
        ) as TList;
        return Future.value(Right(list));
      }
      return Future.value(Right(NomencladorList.fromEmpty() as TList));
    } catch (e) {
      throw HttpServerException(
          response: "000",
          fault: Fault.fromJson({
            "code": "500",
            "type": "Error",
            "message": "Error al listar datos.",
            "description": "Error al listar datos."
          }));
    }
  }

  Future<Either<Exception, TList>> getTrdUnitsFromAssets<TList>() async {
    try {
      String contents = await readFileFromAssets(ASSETS_MODELS_UNIDADES_JSON);
      if (contents.isNotEmpty) {
        final list =
            NomencladorList.fromTrdJson(json.decode(contents)) as TList;
        return Future.value(Right(list));
      }
      return Future.value(Right(NomencladorList.fromEmpty() as TList));
    } catch (e) {
      throw HttpServerException(
          response: "000",
          fault: Fault.fromJson({
            "code": "500",
            "type": "Error",
            "message": "Error al listar datos.",
            "description": "Error al listar datos."
          }));
    }
  }

  @override
  void onInit() {
    httpClient.defaultDecoder = defaultDecoder = super.defaultDecoder = (map) {
      if (map is Map<String, dynamic> && !map.containsKey("fault")) {
        return map.containsKey("orders")
            ? NomencladorList.fromJson(map)
            : NomencladorList.fromJson(map);
      } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
        return Fault.fromJson(map['fault']);
      }
    };
    //httpClient.baseUrl = 'YOUR-API-URL';
  }

  @override
  Future<Either<Exception, TList>> paginate<TList>(
      int start, int limit, params) async {
    ////Map<String, String> headers = getHeader();
    // TODO: implement paginate
    throw UnimplementedError();
  }

  @override
  NomencladorProvider setBaseUrl(String newBaseUrl) {
    super.baseUrl = baseUrl = httpClient.baseUrl = newBaseUrl;
    super.setBaseUrl(baseUrl!);
    return this;
  }

  @override
  Future<Either<Exception, TModel>> updateEntity<TModel>(
      dynamic id, TModel data) async {
    log("Cargando entidad de tipo 'Nomenclador' con identificador=$id");
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
          return NomencladorModel.fromJson(map);
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
