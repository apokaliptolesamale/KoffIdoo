import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:xml/xml.dart';

import '/app/core/services/logger_service.dart';
import '/app/core/services/paths_service.dart';
import '/app/modules/prestashop/service/callbacks.dart';
import '/app/modules/prestashop/service/presta_shop_web_service.dart';
import '/app/modules/prestashop/service/presta_shop_web_service_factory.dart';
import '/app/modules/prestashop/service/query.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/config/errors/fault.dart';
import '../../../../core/interfaces/get_provider.dart';
import '../../domain/models/orderhistory_model.dart';

class OrderHistoryProvider extends GetProviderImpl {
  @override
  Future<Either<Exception, TModel>> addEntity<TModel>(TModel entity) async {
    try {
      if (PrestaShopWebServiceFactory.instance.hasActiveWebService &&
          entity is OrderHistoryModel) {
        /*String url = PrestaShopWebServiceFactory
            .instance.getActiveWebService!.getApi.url;*/
        PrestaShopWebServiceResource<XmlDocument> resource =
            PrestaShopWebServiceFactory.getWebServiceResource(
                "order_histories")!;

        XmlDocument xmlDoc = entity.toXml();

        final toSend = xmlDoc.toXmlString(
          pretty: true,
        );
        final key = resource.getApi.getWebService.key;
        log("Request to update Order Histories:${resource.link}\nData:\n$toSend");
        final credentials = '$key:$key';
        final encodedCredentials = base64.encode(utf8.encode(credentials));
        final headers = {
          'Authorization': 'Basic $encodedCredentials',
          'Content-Type': 'application/xml',
          'Accept': 'application/xml',
        };
        onStatusCodeListener(401, (provider, response, code) async {
          log("Probando manejo de CallBack para Actualizar StatusCode=$code");
          return provider;
        }).onStatusCodeListener(204, (provider, response, code) async {
          log("Probando manejo de CallBack para Actualizar StatusCode=$code");
          return provider;
        }).onStatusCodeListener(500, (provider, response, code) async {
          log("Probando manejo de CallBack para Actualizar StatusCode=$code");
          return provider;
        }).onStatusCodeListener(400, (provider, response, code) async {
          log("Probando manejo de CallBack para Actualizar StatusCode=$code");
          log("Cuerpo de la respuesta:${response.bodyString}");
          return provider;
        });
        log("Url=> ${baseUrl}order_histories");
        final response = await processResponse(post(
          "order_histories",
          toSend,
          //contentType: "application/xml",
          headers: headers,
        ));
        return response.fold((l) => Left(l), (resp) {
          return Right(entity);
        });
        /* if (response .statusCode == 200 || response.statusCode == 201) {
        return Right(entity);
      }
      return Left(HttpServerException(
          fault: Fault.fromJson({
        "code": response.statusCode,
        "type": "Error",
        "message": "Error al intentar cambiar el estado de la orden.",
        "description": "Error al intentar cambiar el estado de la orden."
      })));*/
      }
    } on SocketException {
      throw HttpServerException(
          fault: Fault.fromJson({
        "code": "500",
        "type": "Error",
        "message": "Ocurrió un error de tipo: SocketException.",
        "description":
            "El error de tipo SocketException ocurre cuando no existe conexión disponible entre el cliente y el servidor:${Uri.parse("order_histories").host}."
      }));
    }
    return Left(HttpServerException(
        fault: Fault.fromJson({
      "code": "500",
      "type": "Error",
      "message": "Error al intentar cambiar el estado de la orden.",
      "description": "Error al intentar cambiar el estado de la orden."
    })));
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
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic> && !map.containsKey("fault")) {
        return OrderHistoryList.fromJson(map);
      } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
        return Fault.fromJson(map['fault']);
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
  OrderHistoryProvider setBaseUrl(String newBaseUrl) {
    super.setBaseUrl(httpClient.baseUrl = baseUrl = newBaseUrl);
    return this;
  }

  @override
  Future<Either<Exception, TModel>> updateEntity<TModel>(
      dynamic id, TModel data) async {
    PrestaShopWebService<XmlDocument> webService =
        PrestaShopWebService<XmlDocument>(
      key: PathsService.prestaShopKey,
      hostShop: PathsService.prestaShopHost,
      withSsl: true,
    );
    final loaded = await webService.load();
    log(webService.getApi);
    if (loaded.isLeft()) {
      return Left(HttpServerException500(
          fault: Fault.fromJson({
        "faultCode": "500",
        "type": "Error",
        "message": "Error al intentar actualizar el historial de la orden.",
        "description": "Error al intentar actualizar el historial de la orden."
      })));
    }

    //final resource = webService.getApi.getWebServiceResource("orders");
    // await resource!.getDataService();

    final result = await webService.getApi.update(
      tableName: "order_histories",
      filters: [
        Where(
            key: "id_order_state",
            value: 6,
            next: Where(
              key: "id_order",
              value: 6,
            ))
      ],
      callback: CallBackPrestaShopFunction.updateOrderHistoryState,
    );
    return Future.value(Right(result as TModel));
    //throw UnimplementedError();
  }

  _readFileAsync(String path) async {
    return await rootBundle.loadString(path);
  }
}
