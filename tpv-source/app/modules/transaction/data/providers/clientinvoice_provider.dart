// ignore_for_file: unused_element

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '/app/core/constants/constants.dart';
import '/app/core/helpers/functions.dart';
import '/app/core/interfaces/header_request.dart';
import '/app/core/services/logger_service.dart';
import '/app/core/services/manager_authorization_service.dart';
import '/app/core/services/paths_service.dart';
import '/app/modules/transaction/domain/models/client_service_model.dart';
import '/app/modules/transaction/domain/models/invoice_model.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/config/errors/fault.dart';
import '../../../../core/interfaces/get_provider.dart';
import '../../domain/models/clientinvoice_model.dart';
import '../../domain/models/etecsa_invoice_model.dart';

class ClientInvoiceProvider extends GetProviderImpl {
  Future<Either<Exception, TModel>> addClientId<TModel>(
      Map<String, dynamic> request) async {
    log("Cargando listado de transacciones...");
    String url = '/invoice/v1.0.0/client-id';
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {"Accept": "application/json", "version": Constants.versionApk},
      idpKey: "identity",
    ).getHeaders(accesToken: true);
    /*  Map<String,dynamic> request ={
      "service_code": 10,
      "funding_source_uuid":0,
      "client_id":"",
      "automatic":false,
       "owner": "",
       "metadata":{

       }
    };*/
    final response = await processResponse(post(
      // "$url",
      url,
      request,
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          return ClientServiceModel.fromJson(map);
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

  @override
  Future<Either<Exception, TModel>> addEntity<TModel>(TModel entity) async {
    log("Adicionando nueva entidad de tipo:ClientInvoiceModel.");
    Map<String, dynamic> data = {};
    if (entity is ClientInvoiceModel) {
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
          return ClientInvoiceModel.fromJson(map);
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

  Future<Either<Exception, TModel>> deleteClientId<TModel>(
      dynamic clientId) async {
    log("Cargando listado de bancos...");
    final ms = ManagerAuthorizationService();
    final mas = ms.get(PathsService.identityKey);
    //filters.removeWhere((key, value) => value == null);
    String url = '/invoice/v1.0.0/invoice/$clientId/delete';
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {"Accept": "application/json", "version": Constants.versionApk},
      idpKey: "identity",
    ).getHeaders(accesToken: true);
    final response = await processResponse(delete(
      url,
      headers: headers,
      decoder: (map) {
        log(map);
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          return ClientServiceList.fromJson(map);
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
          return ClientInvoiceModel.fromJson(map);
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
      Map<String, dynamic> params) async {
    log("Cargando listado de transacciones...");
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {"accept": "application/json", "Version": Constants.versionApk},
      idpKey: "identity",
    ).getHeaders(accesToken: true);
    // Map<String, dynamic> filters = {
    //   "limit": 10,
    //   "offset": 0,
    //   "service_code": ServicesPayment.byCodeName("Electricidad")
    // };
    String serviceCode = params["service_code"];
    final query = params.entries.map((p) => '${p.key}=${p.value}').join('&');
    // final query = getShemaQueryFromMap(params);
    String url = '/invoice/v1.0.0/invoice/search?$query';
    late ClientInvoiceList<ClientInvoiceModel> parsed;

    final response = await processResponse(get(
      url,
      headers: headers,
      decoder: (map) {
        log("este es map>>>>>>>>>>>>>>>>>>>>>>>> $map");
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          switch (serviceCode) {
            case "444":
              // final List<dynamic> serviciosData = map['datalist']['data'];
              parsed = ClientInvoiceList.fromEtecsaJson(map);
              // [ClientInvoiceModel.fromEtecsaJson(map)] as EntityModelList;
              // parsed = ClientInvoiceList.fromJson(parsed);
              break;
            //case "6666":
            case "1111":
              parsed = ClientInvoiceList.fromJson(map);
              break;
            case "2222":
              parsed = ClientInvoiceList.fromJson(map);
              break;
            default:
          }

          return parsed;
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

  @override
  Future<Either<Exception, TList>> getAll<TList>(
      // Map<String, dynamic> filters
      ) async {
    log("Cargando listado de bancos...");
    //filters.removeWhere((key, value) => value == null);
    String url = '';
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      idpKey: "apiez",
    ).getHeaders();
    // final query = getShemaQueryFromMap(filters);
    final response = await processResponse(get(
      "$url?$query",
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          return ClientInvoiceModel.fromJson(map);
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
  Future<Either<Exception, TList>> getBy<TList>(Map params) async {
    //Map<String, String> headers = getHeader();
    // TODO: implement paginate
    throw UnimplementedError();
  }

  Future<Either<Exception, TList>> getClientId<TList>(
      Map<String, dynamic> params) async {
    log("Cargando listado de transacciones...");
    String url = '/invoice/v1.0.0/invoice/search?';
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {"Accept": "application/json", "version": Constants.versionApk},
      idpKey: "identity",
    ).getHeaders(accesToken: true);
    final query = getShemaQueryFromMap(params);
    final response = await processResponse(get(
      // "$url",
      "$url$query",
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          return ClientInvoiceList.fromJson(map);
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

  @override
  Future<Either<Exception, TModel>> getEntity<TModel>(dynamic id) async {
    log("Cargando entidad de tipo 'ClientInvoice' con identificador=$id");
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
          return ClientInvoiceModel.fromJson(map);
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
  Future<Either<Exception, TList>> getFactMensualEtecsa<TList>(
      Map<String, dynamic> params) async {
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {"accept": "application/json", "Version": Constants.versionApk},
      idpKey: "identity",
    ).getHeaders(accesToken: true);
    // Map<String, dynamic> filters = {
    //   "limit": 10,
    //   "offset": 0,
    //   "service_code": ServicesPayment.byCodeName("Electricidad")
    // };

    final query = params.entries.map((p) => '${p.key}=${p.value}').join('&');
    // final query = getShemaQueryFromMap(params);
    String url = '/invoice/v1.0.0/invoice/search?$query';

    final response = await processResponse(get(
      url,
      headers: headers,
      decoder: (map) {
        log("este es map>>>>>>>>>>>>>>>>>>>>>>>> $map");
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          return EtecsaModel.fromJson(map);
          // switch (serviceCode) {
          //   case "444":
          //     // final List<dynamic> serviciosData = map['datalist']['data'];
          //     parsed = ClientInvoiceList.fromEtecsaJson(map);
          //     // [ClientInvoiceModel.fromEtecsaJson(map)] as EntityModelList;
          //     // parsed = ClientInvoiceList.fromJson(parsed);
          //     break;
          //   case "6666":
          //   default:
          // }
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

  Future<Either<Exception, TList>> listClientConfig<TList>(
      Map<String, dynamic> filters) async {
    log("Cargando listado de bancos...");
    final ms = ManagerAuthorizationService();
    final mas = ms.get(PathsService.identityKey);
    //filters.removeWhere((key, value) => value == null);
    String url = '/invoice/v1.0.0/client-id/search';
    String serviceCode = "${filters["service"]}";
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {"Accept": "application/json", "version": Constants.versionApk},
      idpKey: "identity",
    ).getHeaders(accesToken: true);
    final query = getShemaQueryFromMap(filters);
    final response = await processResponse(get(
      "$url?$query",
      headers: headers,
      decoder: (map) {
        log(map);
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          //TODO switch con serviceCod
          return ClientServiceList.fromJson(map);
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
  void onInit() {
    httpClient.defaultDecoder = defaultDecoder = super.defaultDecoder = (map) {
      if (map is Map<String, dynamic> && !map.containsKey("fault")) {
        return map.containsKey("orders")
            ? ClientInvoiceList.fromJson(map)
            : ClientInvoiceList.fromJson(map);
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

  Future<Either<Exception, TList>> payEletricityService<TList>(
      Map<String, dynamic> request) async {
    final ms = ManagerAuthorizationService();
    final mas = ms.get(PathsService.identityKey);
    log("Cargando listado de transacciones...");
    String url = '/invoice/v1.0.0/client-id';
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
          return ClientServiceList.fromJson(map);
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

  @override
  ClientInvoiceProvider setBaseUrl(String newBaseUrl) {
    super.setBaseUrl(httpClient.baseUrl = baseUrl = newBaseUrl);
    return this;
  }

  @override
  Future<Either<Exception, TModel>> updateEntity<TModel>(
      dynamic id, TModel data) async {
    log("Cargando entidad de tipo 'ClientInvoice' con identificador=$id");
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
