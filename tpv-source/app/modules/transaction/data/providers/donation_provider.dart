// ignore_for_file: unused_element

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '/app/core/helpers/functions.dart';
import '/app/core/interfaces/header_request.dart';
import '/app/core/services/logger_service.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/config/errors/fault.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/interfaces/get_provider.dart';
import '../../domain/models/donation_model.dart';

class DonationProvider extends GetProviderImpl {
  @override
  Future<Either<Exception, TModel>> addEntity<TModel>(TModel entity) async {
    log("Adicionando nueva entidad de tipo:DonationModel.");
    log('Este es el entity==> $entity');
    CreateDonationModel ad = entity as CreateDonationModel;
    log('Este es addddd==> ${ad.toJson()}');

    String url = '/donation/v1.0.0/donations';
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {
        "accept": "application/json",
        "Version": Constants.versionApk,
      },
      idpKey: "identity",
    ).getHeaders(accesToken: true);

    final response = await processResponse(post(
      url,
      ad.toJson(),
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> &&
            !map.containsKey("fault") &&
            map.containsKey("donation")) {
          log('Lo q viene del createDonation => $map');
          log('Lo q viene del createDonation.fromJson => ${DonationModel.fromJson(map)}');

          return DonationModel.fromJson(map['donation']);
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          /* log('Este es le mensaje que viene del api==> ${map['fault']['message']}');
          log('Este es el fault.fromJson==> ${Fault.fromJson(map['fault'])}'); */
          var mapFault = Fault.fromJson(map['fault']);
          log('Este es el Status Code==> ${mapFault.faultCode}');
          log('Este es el mensaje del fault==>${mapFault.message}');
          log('Este es la descripcion del fault==>${mapFault.description}');
          return HttpServerException(
            fault: Fault.fromJson({
              "code": mapFault.faultCode,
              "type": mapFault.type,
              "message": mapFault.message,
              "description":
                  "Error al crear la donacion. ==> ${mapFault.description}"
            }),
          );
        }
        return map;
      },
    ));

    return response.fold((l) {
      log('Esta es el description del fault del api==> ${l.toString()}');
      return Left(l);
    }, (resp) {
      if (resp.statusCode == 200) {
        log('Este es el StatusText del createDonation=0> ${resp.statusText}');
        log('Este es el BODY del createDonation==> ${resp.body}');
        return Right(resp.body);
      } else {
        log('Este es el StatusCODE del createDonation=0> ${resp.statusCode}');
        log('Este es el StatusText del createDonation=0> ${resp.statusText}');
        log('Este es el BODY del createDonation=0> ${resp.body["fault"]["message"]}');
        throw HttpServerException(
            response: resp,
            fault: Fault.fromJson({
              "code": resp.statusCode,
              "type": "Error",
              "message": resp.body["fault"]["message"],
              "description": "Error al crear la donacion."
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
          return DonationModel.fromJson(map);
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
          return DonationModel.fromJson(map);
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
    log("Cargando listado de donaciones...");
    String url = '/donation/v1.0.0/donations';
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
            map.containsKey("donations")) {
          log('Lo q vieneneidnfoenofainfoiafidnswcofnawdef => ${map['donations']}');
          //log('Lo q vieneneidnfoenofainfoiafidnswcofnawdef => ${DonationModel.fromJson(map)}');

          return DonationList.fromJson(map['donations']);
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
    //Map<String, String> headers = getHeader();
    // TODO: implement paginate
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, TModel>> getEntity<TModel>(dynamic id) async {
    log("Cargando entidad de tipo 'Donation' con identificador=$id");
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
          return DonationModel.fromJson(map);
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
            ? DonationList.fromJson(map)
            : DonationList.fromJson(map);
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
  DonationProvider setBaseUrl(String newBaseUrl) {
    super.setBaseUrl(httpClient.baseUrl = baseUrl = newBaseUrl);
    return this;
  }

  @override
  Future<Either<Exception, TModel>> updateEntity<TModel>(
      dynamic id, TModel data) async {
    log("Cargando entidad de tipo 'Donation' con identificador=$id");
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
          return DonationModel.fromJson(map);
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
