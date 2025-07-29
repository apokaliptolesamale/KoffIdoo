// ignore_for_file: overridden_fields

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
//import '../../../app/modules/operation/widgets/layout_exporting.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:xml/xml.dart';

import '/globlal_constants.dart';
import '../../../app/core/interfaces/header_request.dart';
import '../../../app/core/services/logger_service.dart';
import '../../../app/core/services/manager_authorization_service.dart';
import '../../../app/core/services/ssl_tls_service.dart';
import '../../../app/core/services/user_session.dart';
import '../../core/config/errors/exceptions.dart';
import '../../core/config/errors/fault.dart';
import 'entity_model.dart';

class CustomResponse<T> extends Response<T> {
  @override
  T? body;
  @override
  String? bodyString;
  @override
  Stream<List<int>>? bodyBytes;
  @override
  String? statusText;
  @override
  int? statusCode;
  @override
  Map<String, String>? headers;
  @override
  Request? request;
  GetProviderImpl? _provider;
  CustomResponse(Response<T> resp, {GetProviderImpl? provider})
      : super(
          statusCode: resp.statusCode,
          bodyBytes: resp.bodyBytes,
          statusText: resp.statusText,
          bodyString: resp.bodyString,
          headers: resp.headers,
          request: resp.request,
          body: resp.body,
        ) {
    statusCode = resp.statusCode;
    bodyBytes = resp.bodyBytes;
    statusText = resp.statusText;
    bodyString = resp.bodyString;
    headers = resp.headers;
    request = resp.request;
    body = resp.body;
    _provider = provider;
  }

  factory CustomResponse.wraper(Response<T> resp, {GetProviderImpl? provider}) {
    if (resp.statusCode == null) {
      String str = "curl -k '${resp.request!.url}' ";
      resp.request!.headers.map((key, value) {
        str += " -H '$key: $value' ";
        return MapEntry(key, value);
      });
      log("Error al solicitar recurso: '${resp.request!.url}'\nPuede comprobar el resultado con:\n$str");
    }
    return CustomResponse(
      resp,
      provider: provider,
    );
  }
  Either<Exception, CustomResponse<T>> getHumanResponse() {
    bool isJson = false;
    bool isXml = false;
    late Either<Exception, CustomResponse<T>> result;
    if (bodyString != null &&
        bodyString!.toLowerCase().startsWith('{"timestamp":')) {
      isJson = true;
      final json = jsonDecode(bodyString!);
      json["status"] = EntityModel.getValueFromJson<int?>(
        "status",
        json,
        statusCode ?? 0,
        reader: (key, json, dv) {
          if (json.containsKey(key) && json[key] != null) {
            return json[key];
          } else {
            return dv;
          }
        },
      );
      json["type"] =
          EntityModel.getValueFromJson("error", json, _type(statusCode));
      json["message"] = EntityModel.getValueFromJson(
          "message", json, _getMessages(statusCode));
      json["description"] =
          "${json["error"]} over resource=${json["path"]} with status code ${json["status"]} on timestamp=${json["timestamp"]}.";

      result = Left(HttpServerException(
        response: this,
        fault: Fault.fromJson({
          "code": json["status"],
          "type": json["type"],
          "message": json["message"],
          "description": json["description"]
        }),
      ));
    } else if (bodyString != null &&
        bodyString!.toLowerCase().startsWith('<am:fault')) {
      isXml = true;
      final doc = XmlDocument.parse(bodyString!);
      result = Left(HttpServerException(
          response: this,
          fault:
              Fault.fromXml(doc.rootElement, (el) => Fault.loadFromXml(el))));
    }
    if (statusCode != null && statusCode! >= 200 && statusCode! <= 299) {
      if (statusCode == 204) {
        return Right(CustomResponse.wraper(this));
      }
      return Right(this);
    }

    switch (statusCode) {
      case null:
        return (isJson || isXml)
            ? result
            : Left(HttpServerException(
                response: this,
                fault: Fault.fromJson({
                  "code": statusCode,
                  "type": _type(statusCode),
                  "message": _getMessages(statusCode),
                  "description":
                      "Ha ocurrido un error de conexión. Verifique el estado de la red en su dispositivo o la disponibilidad del recurso.",
                }),
              ));
      case 401:
        return (isJson || isXml)
            ? result
            : Left(HttpServerException(
                response: this,
                fault: Fault.fromJson({
                  "code": statusCode ?? 0,
                  "type": _type(statusCode),
                  "message": _getMessages(statusCode),
                  "description":
                      "Usted no está autorizado(a) para acceder al recurso solicitado.",
                }),
              ));
      case 404:
        return (isJson || isXml)
            ? result
            : Left(HttpServerException(
                response: this,
                fault: Fault.fromJson({
                  "code": statusCode ?? 0,
                  "type": _type(statusCode),
                  "message": _getMessages(statusCode),
                  "description":
                      "Ha ocurrido un error relacionado al recurso de red, no ha sido encontrado o no se puede acceder al recurso.",
                }),
              ));
      case 400:
        return (isJson || isXml)
            ? result
            : Left(HttpServerException(
                response: this,
                fault: Fault.fromJson({
                  "code": statusCode ?? 0,
                  "type": _type(statusCode),
                  "message": _getMessages(statusCode),
                  "description":
                      "Ha ocurrido un error relacionado a la solicitud del recurso: Solicitud incorrecta o con errores.",
                }),
              ));
      case 408:
        return (isJson || isXml)
            ? result
            : Left(HttpServerException(
                response: this,
                fault: Fault.fromJson({
                  "code": statusCode ?? 0,
                  "type": _type(statusCode),
                  "message": _getMessages(statusCode),
                  "description":
                      "Ha ocurrido un error relacionado a la solicitud del recurso: Tiempo de espera prolongado.",
                }),
              ));
      default:
        return (isJson || isXml)
            ? result
            : Left(HttpServerException(
                response: this,
                fault: Fault.fromJson({
                  "code": statusCode ?? 0,
                  "type": _type(statusCode),
                  "message": _getMessages(statusCode),
                  "description":
                      "Ha ocurrido un error desconocido o sin tratamiento. Consulte al administrador o proveedor del servicio.",
                }),
              ));
    }
  }

  _fromListener(Response response, int? code) {
    log(_provider != null ? 'Provider=$_provider' : 'Sin provider');
    log(code != null ? 'StatusCode=$code' : 'Sin StatusCode');
    if (_provider != null && code != null) {
      final listener = _provider!.getByStatusCode(code);
      if (listener != null) {
        return listener.call(_provider!, response, code);
      }
    }
    return null;
  }

  String _getMessages(int? code) {
    if (code == null) return "Error de conexión o recurso no disponible.";
    if (code >= 100 && code <= 199) return "Respuestas informativa";
    if (code >= 200 && code <= 299) return "Respuestas satisfactoria";
    if (code >= 300 && code <= 399) return "Redirección";
    if (code >= 400 && code <= 499) {
      switch (code) {
        case 401:
          return "Error en el cliente: sin autorización.";
        default:
      }
      return "Error en el cliente";
    }
    if (code >= 500 && code <= 599) return "Error en el servicio";
    return "Desconocido";
  }

  String _type(int? code) {
    if (code == null) return "error";
    if (code >= 100 && code <= 199) return "info";
    if (code >= 200 && code <= 299) return "info";
    if (code >= 300 && code <= 399) return "info";
    if (code >= 400 && code <= 499) return "error";
    if (code >= 500 && code <= 599) return "error";
    return "Desconocido";
  }
}

class GetConnectProvider extends GetConnect {
  @override
  bool allowAutoSignedCert;
  @override
  String userAgent;
  @override
  Duration timeout;
  @override
  bool sendUserAgent;
  @override
  String? baseUrl;
  @override
  String defaultContentType = 'application/json; charset=utf-8';
  @override
  bool followRedirects;
  @override
  int maxRedirects;
  @override
  int maxAuthRetries;
  @override
  bool withCredentials;
  dynamic Function(dynamic)? decoder;
  @override
  List<TrustedCertificate>? trustedCertificates;
  late Map<String, String> _headers;

  GetConnectProvider({
    required this.decoder,
    Map<String, String> headers = const {},
    this.userAgent = 'getx-client',
    this.timeout = const Duration(seconds: 5),
    this.followRedirects = true,
    this.maxRedirects = 5,
    this.sendUserAgent = false,
    required this.baseUrl,
    this.maxAuthRetries = 1,
    this.allowAutoSignedCert = true,
    this.withCredentials = false,
    this.trustedCertificates,
  }) : super(
          userAgent: userAgent,
          allowAutoSignedCert: allowAutoSignedCert,
          followRedirects: followRedirects,
          maxAuthRetries: maxAuthRetries,
          maxRedirects: maxRedirects,
          sendUserAgent: sendUserAgent,
          timeout: timeout,
          withCredentials: withCredentials,
        ) {
    super.trustedCertificates =
        trustedCertificates ?? SslTlsService.getInstance.getTrustedCertificate;
    _headers = headers;
    setBaseUrl(baseUrl ?? "");
    super.defaultDecoder = decoder;
    super.defaultContentType = "*/*";
  }
  @override
  GetHttpClient get httpClient {
    final client = GetHttpClient(
      userAgent: userAgent,
      sendUserAgent: sendUserAgent,
      timeout: timeout,
      followRedirects: followRedirects,
      maxRedirects: maxRedirects,
      maxAuthRetries: maxAuthRetries,
      allowAutoSignedCert: allowAutoSignedCert,
      baseUrl: baseUrl,
      trustedCertificates: trustedCertificates,
      withCredentials: withCredentials,
      findProxy: findProxy,
    );
    return client;
  }

  Future<Response<String>> getFromUrl(String url) => get<String>(url);

  List<TrustedCertificate>? getTrustedCertificates() => trustedCertificates;

  @override
  void onInit() {
    // All request will pass to jsonEncode so CasesModel.fromJson()
    httpClient.baseUrl = baseUrl;
    httpClient.defaultDecoder = decoder;
    httpClient.addRequestModifier<Object?>((request) async {
      //request.headers['Authorization'] = 'Bearer sdfsdfgsdfsdsdf12345678';
      _headers.addAll(await HeaderRequestImpl(
        idpKey: "apiez",
      ).getHeaders());
      request.headers.addAll(_headers);
      return request;
    });
  }

  GetConnectProvider setBaseUrl(String newBaseUrl) {
    httpClient.baseUrl = baseUrl = newBaseUrl;
    return this;
  }
}

class GetDefautlProviderImpl extends GetProviderImpl {
  @override
  Map<
          int,
          dynamic Function(
              GetProviderImpl provider, Response response, int statusCode)>
      statusCodeListeners = {};
  //Atributos
  @override
  bool allowAutoSignedCert;
  @override
  String userAgent;
  @override
  Duration timeout;
  @override
  bool sendUserAgent;
  @override
  String? baseUrl;
  @override
  String defaultContentType = 'application/json; charset=utf-8';
  @override
  bool followRedirects;
  @override
  int maxRedirects;
  @override
  int maxAuthRetries;
  @override
  bool withCredentials;
  @override
  List<TrustedCertificate>? trustedCertificates;

  GetDefautlProviderImpl({
    this.userAgent = 'getx-client',
    this.timeout = const Duration(seconds: 5),
    this.followRedirects = true,
    this.maxRedirects = 5,
    this.sendUserAgent = false,
    this.maxAuthRetries = 1,
    this.allowAutoSignedCert = true,
    this.withCredentials = false,
    this.trustedCertificates,
    this.baseUrl = "",
    Map<String, String>? headers,
  }) : super(
          userAgent: userAgent,
          allowAutoSignedCert: allowAutoSignedCert,
          followRedirects: followRedirects,
          maxAuthRetries: maxAuthRetries,
          maxRedirects: maxRedirects,
          sendUserAgent: sendUserAgent,
          timeout: timeout,
          withCredentials: withCredentials,
          decoder: (_) {},
          trustedCertificates: trustedCertificates,
          headers: headers ?? {},
        );

  @override
  String get getBaseUrl => httpClient.baseUrl!;

  @override
  dynamic Function(GetProviderImpl, Response, int statusCode)? getByStatusCode(
      int statusCode) {
    return hasStatusCodeListener(statusCode)
        ? statusCodeListeners[statusCode]
        : null;
  }

  @override
  Map<String, String> getHeader() {
    final service = ManagerAuthorizationService().get(defaultIdpKey);
    UserSession? usession = service?.getUserSession();
    if (usession != null &&
        usession.getToken != null &&
        usession.hasExpired()) {
      _headers['Authorization'] = usession.getToken!;
    } else {
      _headers.remove('Authorization');
    }
    return _headers;
  }

  @override
  bool hasStatusCodeListener(int statusCode) {
    return statusCodeListeners.containsKey(statusCode);
  }

  @override
  GetDefautlProviderImpl onStatusCodeListener(
      int statusCode,
      dynamic Function(
              GetProviderImpl provider, Response response, int statusCode)
          func) {
    statusCodeListeners[statusCode] = func;
    return this;
  }

  @override
  Future<Either<Exception, Response<T>>> processResponse<T>(
    Future<Response<T>> response, {
    GetProviderImpl? provider,
  }) async {
    final resp = await response;
    return Future.value(
      CustomResponse.wraper(resp, provider: provider).getHumanResponse(),
    );
  }

  @override
  setBaseUrl(String newBaseUrl) {
    super.baseUrl = httpClient.baseUrl = baseUrl = newBaseUrl;
    return this;
  }

  @override
  setDecoder(dynamic Function(dynamic)? newDecoder) {
    super.decoder = decoder = newDecoder;
  }
}

abstract class GetProvider {
  Future<Either<Exception, TModel>> addEntity<TModel>(TModel entity);
  Future<Either<Exception, TModel>> deleteEntity<TModel>(dynamic id);
  Future<Either<Exception, TList>> filter<TList>(Map<String, dynamic> filters);
  Future<Either<Exception, TList>> getAll<TList>();
  Future<Either<Exception, TList>> getBy<TList>(Map params);
  Future<Either<Exception, TModel>> getEntity<TModel>(dynamic id);
  Future<Either<Exception, TList>> paginate<TList>(
      int start, int limit, dynamic params);
  Future<Either<Exception, TModel>> updateEntity<TModel>(
      dynamic id, TModel data);
}

class GetProviderImpl extends GetConnectProvider implements GetProvider {
  Map<
          int,
          dynamic Function(
              GetProviderImpl provider, Response response, int statusCode)>
      statusCodeListeners = {};
  //Atributos
  @override
  bool allowAutoSignedCert;
  @override
  String userAgent;
  @override
  Duration timeout;
  @override
  bool sendUserAgent;
  @override
  String? baseUrl;
  @override
  String defaultContentType = 'application/json; charset=utf-8';
  @override
  bool followRedirects;
  @override
  int maxRedirects;
  @override
  int maxAuthRetries;
  @override
  bool withCredentials;
  @override
  dynamic Function(dynamic)? decoder;
  @override
  List<TrustedCertificate>? trustedCertificates;
  @override
  final Map<String, String> _headers = {};

  late int statusCode;

  GetProviderImpl({
    this.userAgent = 'getx-client',
    this.baseUrl,
    this.timeout = const Duration(seconds: 5),
    this.followRedirects = true,
    this.maxRedirects = 5,
    this.sendUserAgent = false,
    this.maxAuthRetries = 1,
    this.allowAutoSignedCert = true,
    this.withCredentials = false,
    this.decoder,
    this.trustedCertificates,
    Map<String, String> headers = const {},
  }) : super(
          userAgent: userAgent,
          allowAutoSignedCert: allowAutoSignedCert,
          followRedirects: followRedirects,
          maxAuthRetries: maxAuthRetries,
          maxRedirects: maxRedirects,
          sendUserAgent: sendUserAgent,
          timeout: timeout,
          withCredentials: withCredentials,
          decoder: decoder ?? (_) {},
          trustedCertificates: trustedCertificates,
          headers: headers,
          baseUrl: baseUrl,
        );

  String get getBaseUrl => httpClient.baseUrl = super.baseUrl = baseUrl!;

  @override
  Future<Either<Exception, TModel>> addEntity<TModel>(TModel entity) {
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

  fireListeners(Response response, int statuscode) {
    statusCodeListeners.map((key, value) {
      key == statuscode ? value(this, response, key) : null;
      return MapEntry(key, value);
    });
  }

  @override
  Future<Either<Exception, TList>> getAll<TList>() {
    // TODO: implement getAlls
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, TList>> getBy<TList>(Map params) {
    // TODO: implement paginate
    throw UnimplementedError();
  }

  dynamic Function(GetProviderImpl provider, Response response, int statusCode)?
      getByStatusCode(int statusCode) {
    return hasStatusCodeListener(statusCode)
        ? statusCodeListeners[statusCode]
        : null;
  }

  @override
  Future<Either<Exception, TModel>> getEntity<TModel>(id) {
    // TODO: implement getEntity
    throw UnimplementedError();
  }

  Map<String, String> getHeader() {
    final service = ManagerAuthorizationService().get(defaultIdpKey);
    UserSession? usession = service?.getUserSession();
    if (usession != null &&
        usession.getToken != null &&
        !usession.hasExpired()) {
      _headers['Authorization'] = usession.getToken!;
    } else {
      _headers.remove('Authorization');
    }
    return _headers;
  }

  bool hasStatusCodeListener(int statusCode) {
    return statusCodeListeners.containsKey(statusCode);
  }

  GetProviderImpl onStatusCodeListener(
      int statusCode,
      dynamic Function(
              GetProviderImpl provider, Response response, int statusCode)
          func) {
    statusCodeListeners[statusCode] = func;
    return this;
  }

  @override
  Future<Either<Exception, TList>> paginate<TList>(
      int start, int limit, params) {
    // TODO: implement paginate
    throw UnimplementedError();
  }

  Future<Either<Exception, Response<T>>> processResponse<T>(
    Future<Response<T>> response, {
    GetProviderImpl? provider,
  }) async {
    final resp = await response;
    final result = Future.value(
        CustomResponse.wraper(resp, provider: provider).getHumanResponse());
    if (resp.statusCode != null) {
      fireListeners(resp, statusCode = resp.statusCode!);
    }
    return result;
  }

  @override
  setBaseUrl(String newBaseUrl) {
    httpClient.baseUrl = super.baseUrl = baseUrl = newBaseUrl;
    return this;
  }

  setDecoder(dynamic Function(dynamic)? newDecoder) {
    super.decoder = decoder = newDecoder;
  }

  Future<Either<Exception, T>> tryProvider<T>(
      Future<Either<Exception, T>> Function() calleable) async {
    try {
      final response = await calleable();
      return response;
    } on TimeoutException catch (e) {
    } on SocketException catch (e) {
    } on Error catch (e) {
    } on PlatformException catch (e) {}

    return Future.value(Left(HttpServerException(
        fault: Fault(
      faultCode: 500,
      type: "Internal Server Error",
      message: "Ha ocurrido un error interno.",
      description: "Ha ocurrido un error interno.",
    ))));
  }

  @override
  Future<Either<Exception, TModel>> updateEntity<TModel>(
      dynamic id, TModel data) {
    // TODO: implement updateEntity
    throw UnimplementedError();
  }
}
