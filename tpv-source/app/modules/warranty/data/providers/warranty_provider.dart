import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:xml/xml.dart';

import '/app/core/config/errors/fault.dart';
import '/app/core/interfaces/header_request.dart';
import '/app/core/services/logger_service.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/interfaces/get_provider.dart';
import '../../domain/models/warranty_model.dart';

class WarrantyProvider extends GetProviderImpl {
  @override
  Future<Either<Exception, TModel>> addEntity<TModel>(TModel entity) async {
    final datos = entity;

    if (datos is Map) {
      log(datos);
      datos.removeWhere((key, value) =>
          value == null || (value != null && value.toString().isEmpty));
    }

    final url = "warranty/create";
    log("Sending post to url:$baseUrl$url");
    final himpl = HeaderRequestImpl(
      idpKey: "apiez",
    );
    Map<String, String> headers = await himpl.getHeaders();
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
    log("Datos para crear garantía desde comercio físico:$datos");
    final response = await processResponse(
      post(
        url,
        datos,
        headers: headers,
        decoder: (data) {
          if (data.toString().startsWith("<am:fault")) {
            return HttpServerException(
                fault: Fault.loadFromXml(XmlDocument.parse(data).rootElement));
          }
          datos is Map ? datos["warrantyId"] = data : null;
          log("Se adicionó un nuevo certificado de garantía:$data");
          return WarrantyModel.fromJson(datos as Map<String, dynamic>);
        },
      ),
      provider: this,
    );
    return response.fold((l) => Left(l), (resp) {
      if (resp.body is WarrantyModel) {
        return Right(resp.body as TModel);
      } else {
        return Right((resp.bodyString!.isNotEmpty
            ? WarrantyModel.fromJson(json.decode(resp.bodyString!))
            : WarrantyModel.fromJson({})) as TModel);
      }
    });
  }

  @override
  Future<Either<Exception, TModel>> deleteEntity<TModel>(id) {
    // TODO: implement deleteEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, TList>> filter<TList>(
      Map<String, dynamic> filters) async {
    return tryProvider<TList>(() async {
      /*final path = ASSETS_MODELS_WARRANTIES_XML;
      final tmp = filters;
      String? content = await _readFileAsync(path);
      final xml = XmlDocument.parse(content);
      return Future.value(Right(WarrantyList.fromXmlDocument(xml, (el) {
        int start = filters["page"] * filters["count"];
        int end = filters["count"] + start;
        return WarrantyList.fromRange(
            WarrantyList.fromXmlElement(el), start, end);
      }) as TList));*/
      filters.removeWhere(
          (key, value) => value == null || (value is List && value.isEmpty));
      final query = Uri(
          queryParameters: filters
              .map((key, value) => MapEntry(key, value.toString()))).query;
      final url = "queries/filter?$query";
      Map<String, String> headers = await HeaderRequestImpl(
        headers: {"accept": "application/xml"},
        idpKey: "apiez",
      ).getHeaders();
      info("Url de garantías==>>>$baseUrl$url");
      onStatusCodeListener(401, (provider, response, code) async {
        log("Probando manejo de CallBack para StatusCode=$code");
        return provider;
      }).onStatusCodeListener(500, (provider, response, statusCode) {
        log("Probando manejo de CallBack para StatusCode=$statusCode");
        return provider;
      }).onStatusCodeListener(503, (provider, response, statusCode) {
        log("Probando manejo de CallBack para StatusCode=$statusCode");
        return provider;
      });
      final resp = await processResponse(
        get(
          url,
          headers: headers,
          decoder: (map) => defaultDecoder!(map),
        ),
        provider: this,
      );
      return resp.fold((l) => Left(l), (resp) {
        if (resp.body is WarrantyList) {
          return Right(resp.body as TList);
        } else {
          return Right((resp.bodyString!.isNotEmpty
              ? WarrantyList.fromXmlStringElement(resp.bodyString!)
              : WarrantyList.fromJson({})) as TList);
        }
      });
    });
  }

  @override
  Future<Either<Exception, TList>> getAll<TList>() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, TModel>> getEntity<TModel>(dynamic id) async {
    final url = "queries/warranty?warrantyId=$id";
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {"accept": "application/xml"},
      idpKey: "apiez",
    ).getHeaders();
    info("Url de garantía==>>>$baseUrl$url");
    final resp = await processResponse(
      get(
        url,
        headers: headers,
        decoder: super.decoder = decoder = (map) {
          map = map.toString().replaceAll("SaveModel", "item");
          map =
              map.toString().contains("<?xml version='1.0' encoding='UTF-8'?>")
                  ? map
                  : '<?xml version="1.0" encoding="UTF-8"?>$map';
          log("Se recibe:\n$map");
          try {
            final root = XmlDocument.parse(map).rootElement;
            if (root.getAttribute("warrantyId") != null) {
              return Right(WarrantyModel.fromXmlElement(root));
            }
            throw EmptyResposeException(
              response: null,
              fault: Fault.fromJson(
                {
                  "code": "000",
                  "type": "Error",
                  "message": "Error al filtrar listado.",
                  "description": "Error al filtrar listado."
                },
              ),
            );
          } catch (e) {
            return Left(e);
          }
        },
      ),
      provider: this,
    );
    return resp.fold((l) => Left(l), (resp) {
      if (resp.body is WarrantyModel) {
        return Right(resp.body as TModel);
      } else if (resp.body is WarrantyList) {
        return Right(resp.body as TModel);
      } else {
        return Right((resp.bodyString!.isNotEmpty
            ? WarrantyModel.fromXmlStringElement(resp.bodyString!)
            : WarrantyModel.fromJson({})) as TModel);
      }
    });
  }

  @override
  void onInit() {
    httpClient.defaultContentType = "application/xml";
    httpClient.defaultDecoder = super.defaultDecoder = defaultDecoder = (map) {
      log(map);
      return WarrantyList.fromXmlElement(
          XmlDocument.parse('<?xml version="1.0" encoding="UTF-8"?>$map')
              .rootElement);
    };
  }

  @override
  Future<Either<Exception, TList>> paginate<TList>(
      int start, int limit, params) {
    // TODO: implement paginate
    throw UnimplementedError();
  }

  @override
  WarrantyProvider setBaseUrl(String newBaseUrl) {
    super.setBaseUrl(httpClient.baseUrl = baseUrl = newBaseUrl);
    return this;
  }

  @override
  Future<Either<Exception, TModel>> updateEntity<TModel>(
      dynamic id, TModel data) {
    // TODO: implement updateEntity
    throw UnimplementedError();
  }

  Future<String> _readFileAsync(String path) async {
    return rootBundle.loadString(path);
  }
}
