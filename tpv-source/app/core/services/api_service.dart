// ignore_for_file: overridden_fields

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../config/errors/exceptions.dart';
import '../config/errors/fault.dart';
import 'default_header_request_service.dart';
import 'logger_service.dart';
import 'paths_service.dart';

class ApiService extends GetConnect implements ApiServiceInterface {
  static final ApiService getInstance = ApiService._internal();
  final Map<String, String> _services = {};

  @override
  String? baseUrl = PathsService.apiEndpoint;

  factory ApiService() {
    return getInstance;
  }

  ApiService._internal() {
    log("Inicializando instancia de registro de servicios de API");
  }

  @override
  String get getBaseUrl => baseUrl!;

  @override
  Map<String, String> get getServices => _services;

  @override
  String? operator [](service) {
    final Map<String, String> services = getServices;
    return services.containsKey(service) ? services[service] : null;
  }

  String getService(String service) {
    return this[service]!;
  }

  String registry(String context, String service) {
    final newService = getBaseUrl + context + service;
    log("Registrando servicio [$service] en url $newService ");
    return _services.putIfAbsent(service, () => newService);
  }

  static Future<Either<Exception, dynamic>> getCoordinates() async {
    Map<String, String> headers =
        DefaultHeaderRequestService.getHttpDefaulHeader();
    final String url =
        ApiService.getInstance.getService("nomenclator/coordinates");
    log("Solicitando coordenadas para activación de tarjeta bancaria...");
    final resp = await ApiService.getInstance.get(
      url,
      contentType: 'application/json',
      headers: headers,
    );
    if (resp.body is Fault) {
      log("Error solicitando coordenadas para activación de tarjeta bancaria...");
      return Left(HttpServerException(fault: resp.body));
    }
    log("Retornando coordenadas para activación de tarjeta bancaria...");
    return Right(resp.body);
  }
}

abstract class ApiServiceInterface extends GetConnectInterface {
  String get getBaseUrl => PathsService.apiEndpoint;
  Map<String, String> get getServices => {};
  String? operator [](service);
}
