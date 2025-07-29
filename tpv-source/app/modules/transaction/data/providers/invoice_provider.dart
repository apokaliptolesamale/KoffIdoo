// ignore_for_file: unused_element

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '/app/core/constants/constants.dart';
import '/app/core/helpers/functions.dart';
import '/app/core/interfaces/header_request.dart';
import '/app/core/services/logger_service.dart';
import '/app/modules/transaction/domain/models/invoice_charged_model.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/config/errors/fault.dart';
import '../../../../core/interfaces/get_provider.dart';
import '../../domain/models/invoice_model.dart';

class InvoiceProvider extends GetProviderImpl {
  @override
  Future<Either<Exception, TModel>> addEntity<TModel>(TModel entity) async {
    log("Adicionando nueva entidad de tipo:InvoiceModel.");
    Map<String, dynamic> data = {};
    if (entity is InvoiceModel) {
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
          return InvoiceModel.fromJson(map);
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
          return InvoiceModel.fromJson(map);
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
    log("Cargando listado de recibos...");
    String url = '/invoice/v1.0.0/invoice?';
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {"Accept": "application/json", "version": Constants.versionApk},
      idpKey: "identity",
    ).getHeaders(accesToken: true);
    /* Map<String, dynamic> filters = {
      "limit": 10,
      "offset": 0,
      "service_code": 2222
    };*/
    final query = getShemaQueryFromMap(filters);
    final response = await processResponse(get(
      "$url$query",
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          return InvoiceList.fromJson(map);
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
  Future<Either<Exception, TList>> getAll<TList>() async {
    log("Cargando listado de recibos...");
    String url = '/invoice/v1.0.0/invoice?';
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {"Accept": "application/json", "version": Constants.versionApk},
      idpKey: "identity",
    ).getHeaders(accesToken: true);
    Map<String, dynamic> filters = {
      "limit": 10,
      "offset": 0,
      "service_code": 2222
    };
    final query = getShemaQueryFromMap(filters);
    final response = await processResponse(get(
      "$url$query",
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          return InvoiceList.fromJson(map);
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

  /* Future<Either<HttpServerException, TModel>> getClientId<TModel>(
      Map<String, dynamic> filters) async {
    log("Cargando entidad de tipo 'Invoice' con identificador=$id");
    String url = '/invoice/v1.0.0/invoice/search?';
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {"Accept": "application/json", "version": Constants.versionApk},
      idpKey: "identity",
    ).getHeaders(accesToken: true);
    final query = getShemaQueryFromMap(filters);
    final response = await processResponse(get(
      '$url$query',
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          return InvoiceModel.fromJson(map);
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
  }*/

  @override
  Future<Either<Exception, TModel>> getEntity<TModel>(dynamic id) async {
    log("Cargando entidad de tipo 'Invoice' con identificador=$id");
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
          return InvoiceModel.fromJson(map);
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
            ? InvoiceList.fromJson(map)
            : InvoiceList.fromJson(map);
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
  InvoiceProvider setBaseUrl(String newBaseUrl) {
    super.setBaseUrl(httpClient.baseUrl = baseUrl = newBaseUrl);
    return this;
  }

  @override
  Future<Either<Exception, TModel>> updateEntity<TModel>(
      dynamic id, TModel data) async {
    log("Cargando entidad de tipo 'Invoice' con identificador=$id");
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
          return InvoiceModel.fromJson(map);
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

  Future<Either<Exception, TModel>> getClientId<TModel>(
      Map<String, dynamic> filters) async {
    log("Cargando entidad de tipo 'Invoice' con identificador=$id");
    String url = '/invoice/v1.0.0/invoice/search?';
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {"Accept": "application/json", "version": Constants.versionApk},
      idpKey: "identity",
    ).getHeaders(accesToken: true);
    final query = getShemaQueryFromMap(filters);
    final response = await processResponse(get(
      '$url$query',
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          return InvoiceModel.fromJson(map);
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

  Future<Either<Exception, TModel>> payEletricityService<TModel>(
      Map<String, dynamic> request) async {
    log("Cargando listado de transacciones...");
    String url = '/invoice/v1.0.0/invoice/payment';
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {"Accept": "application/json", "version": Constants.versionApk},
      idpKey: "identity",
    ).getHeaders(accesToken: true);
    final response = await processResponse(post(
      url,
      request,
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          return InvoiceChargedModel.fromJson(map);
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },
    ));

    return response.fold((l) {
      log(l.toString());
      return Left(l);
    }, (resp) {
      if (resp.statusCode == 200) {
        log(resp.body);
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

  Future<Either<Exception, TList>> getInvoiceByClientId<TList>(
      Map<String, dynamic> params) async {
    log("Cargando listado de recibos...");
    String url = '/invoice/v1.0.0/invoice?';
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {"Accept": "application/json", "version": Constants.versionApk},
      idpKey: "identity",
    ).getHeaders(accesToken: true);
    Map<String, dynamic> filters = {
      "limit": 10,
      "offset": 0,
    };
    final query = getShemaQueryFromMap(params);
    final response = await processResponse(get(
      "$url$query",
      headers: headers,
      decoder: (map) {
        Map<String, dynamic> resultMap = {};

        if (map is Map<String, dynamic> &&
            map.containsKey("invoice") &&
            map["invoice"] is List) {
          log(map["invoice"].toString());

          return InvoiceList.fromEmpty();
        } else if (map is Map<String, dynamic> && map.containsKey("invoice")) {
          log(map.toString());
          resultMap["invoice"] = [Map<String, dynamic>.from(map["invoice"])];
          return InvoiceList.fromJson(resultMap);
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },
    ));
    return response.fold((l) => Left(l), (resp) {
      if (resp.statusCode == 200) {
        log(resp.body.toString());
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
