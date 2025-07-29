// ignore_for_file: prefer_function_declarations_over_variables, unused_element

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:xml/xml.dart';

import '/app/core/interfaces/header_request.dart';
import '/app/core/services/logger_service.dart';
import '/app/core/services/paths_service.dart';
import '/app/modules/prestashop/service/callbacks.dart';
import '/app/modules/prestashop/service/presta_shop_web_service.dart';
import '/app/modules/prestashop/service/presta_shop_web_service_factory.dart';
import '/app/modules/prestashop/service/query.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/config/errors/fault.dart';
import '../../../../core/interfaces/get_provider.dart';
import '../../domain/models/order_model.dart';

class OrderProvider extends GetProviderImpl {
  @override
  Future<Either<Exception, TModel>> addEntity<TModel>(TModel entity) async {
    Map<String, String> headers = getHeader();
    final datos = (entity as OrderModel).toJson();
    datos.removeWhere(
        (key, value) => value == null || (value is List && value.isEmpty));
    // log(datos);
    //httpClient.baseUrl = baseUrl;
    final response = await post(
      "order/createOrder",
      datos,
      contentType: 'application/json',
      headers: headers,
    );
    if (response.statusCode == 200) {
      //entity.uuid = response.bodyString;
      //log(response.bodyString);
      return Right(entity);
    } else {
      throw HttpServerException(
          response: response,
          fault: Fault.fromJson({
            "code": response.statusCode,
            "type": "Error",
            "message": "Error al crear una Orden.",
            "description": "Error al crear una Orden."
          }));
    }
  }

  @override
  Future<Either<Exception, TModel>> deleteEntity<TModel>(id) {
    // TODO: implement deleteEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, TList>> filter<TList>(
      Map<String, dynamic> filters) async {
    filters.removeWhere(
        (key, value) => value == null || (value is List && value.isEmpty));

    final url = "order/getByFilter?${Uri(queryParameters: filters).query}";

    log("Órdenes desde $baseUrl$url");
    final himpl = HeaderRequestImpl(
      idpKey: "apiez",
    );
    Map<String, String> headers = await himpl.getHeaders();
    onStatusCodeListener(401, (provider, response, code) async {
      log("Probando manejo de CallBack para StatusCode=$code");
      return provider;
    }).onStatusCodeListener(204, (provider, response, code) async {
      log("Probando manejo de CallBack para StatusCode=$code");
      httpClient.defaultDecoder =
          defaultDecoder = super.defaultDecoder = (map) {
        if (map is Map<String, dynamic> &&
            !map.containsKey("fault") &&
            map.isNotEmpty) {
          return OrderModel.fromJson(map);
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return OrderList.fromJson(map);
      };
      return provider;
    }).onStatusCodeListener(500, (provider, response, code) async {
      log("Probando manejo de CallBack para StatusCode=$code");
      return provider;
    });
    final resp = await processResponse(
      get(
        url,
        headers: headers,
        decoder: defaultDecoder,
      ),
      provider: this,
    );
    return resp.fold((l) {
      log("Error en order_provider, linea 97:${l.toString()}");
      return Left(l);
    }, (resp) {
      if (resp.body is OrderList) {
        return Right(resp.body as TList);
      } else {
        return Right((resp.bodyString!.isNotEmpty
            ? OrderList.fromStringJson(resp.bodyString!)
            : OrderList.fromJson({})) as TList);
      }
    });
  }

  @override
  Future<Either<Exception, TList>> getAll<TList>() async {
    PrestaShopWebService<XmlDocument> webService =
        PrestaShopWebServiceFactory.create(
            PathsService.prestaShopHost, PathsService.prestaShopKey);
    final loaded = await webService.load();
    if (loaded.isLeft()) return Right(OrderList.fromJson({}) as TList);
    // throw (loaded as Left).value;

    final resource = webService.getApi.getWebServiceResource("orders");
    await resource!.getDataService();

    final result = await webService.getApi.executeQuery(
      tableName: "orders",
      filters: [
        Where(
          key: "current_state",
          value: 24,
        )
      ],
      limit: 40,
      offSet: 1,
      callback: CallBackPrestaShopFunction.getOrders,
    );
    //log("Total:${result != null ? result.getTotal : 0}");
    return Right(result as TList);
    /*final response = await webService.execute("GET", {});

    response.fold((l) => null, (xml) {
      log(xml);
    });*/

    /*final url = "assets/models/orders.json";
    final orders = await _readFileAsync(url);
    return Right(OrderList.fromStringJson(orders) as TList);
    final url = "/warranty/orders";
    Map<String, String> headers =
        DefaultHeaderRequestService.getHttpDefaulHeader();

    final resp = await get(
      url,
      //body,
      contentType: 'application/json',
      headers: headers,
    );

    if (resp.body is Fault) {
      log("Error solicitando listado de ordenes...");
      return Left(HttpServerException(fault: resp.body));
    }
    log("Retornando listado de ordenes...");
    return Right(OrderList.fromStringJson(resp.bodyString!).orders as TList);*/
  }

  Future<Either<Exception, TModel>> getOrder<TModel>(dynamic id) async {
    final url = "order/getById?id=$id";
    final himpl = HeaderRequestImpl(
      idpKey: "apiez",
    );
    Map<String, String> headers = await himpl.getHeaders();

    onStatusCodeListener(401, (provider, response, code) async {
      log("Probando manejo de CallBack para StatusCode=$code");
      return provider;
    }).onStatusCodeListener(204, (provider, response, code) async {
      log("Probando manejo de CallBack para StatusCode=$code");
      httpClient.defaultDecoder =
          defaultDecoder = super.defaultDecoder = (map) {
        return OrderModel.fromJson(map) as TModel;
      };
      return provider;
    }).onStatusCodeListener(500, (provider, response, code) async {
      log("Probando manejo de CallBack para StatusCode=$code");
      return provider;
    });
    log("Url getOrder:$baseUrl$url");
    final resp = await processResponse(
      get(
        url,
        headers: headers,
        decoder: (data) {
          return OrderModel.fromJson(data) as TModel;
        },
      ),
      provider: this,
    );
    return resp.fold((l) => Left(l), (resp) {
      if (resp.body is TModel) {
        return Right(resp.body as TModel);
      } else {
        return Right((resp.bodyString!.isNotEmpty
            ? OrderModel.fromStringJson(resp.bodyString!)
            : OrderModel.fromJson({})) as TModel);
      }
    });
/*
    final resp = await get(
      url,
      headers: headers,
    );

    if (resp.body is Fault || resp.body == null) {
      log("Error solicitando orden en url: ${httpClient.baseUrl}$url");
      return Left(HttpServerException(
          fault: resp.body is Fault
              ? resp.body
              : Fault.fromJson({
                  "faultCode": 500,
                  "type": "Error",
                  "message": "Error en la llamada",
                  "description": "Error en la llamada"
                })));
    }
    log("Retornando Orden...");
    if (resp.body is OrderModel) {
      return Right(resp.body as TModel);
    } else {
      return Right(OrderModel.fromJson(jsonDecode(resp.bodyString!)) as TModel);
    }*/
  }

  @override
  void onInit() {
    httpClient.defaultDecoder = defaultDecoder = super.defaultDecoder = (map) {
      if (map.toString().startsWith('<?xml version="1.0" encoding="UTF-8"?>')) {
        return XmlDocument.parse(map);
      }
      if (map is Map<String, dynamic> && !map.containsKey("fault")) {
        return map.containsKey("orders")
            ? OrderList.fromJson(map)
            : OrderModel.fromJson(map);
      } else if (map != null && map is Map && map.containsKey("fault")) {
        return OrderList.fromJson({}); // Fault.fromJson(map['fault']);
      }
    };
    //httpClient.baseUrl = 'YOUR-API-URL';
  }

  @override
  Future<Either<Exception, TList>> paginate<TList>(
      int start, int limit, params) {
    // TODO: implement paginate
    throw UnimplementedError();
  }

  @override
  OrderProvider setBaseUrl(String newBaseUrl) {
    super.setBaseUrl(httpClient.baseUrl = baseUrl = newBaseUrl);
    return this;
  }

  @override
  Future<Either<Exception, TModel>> updateEntity<TModel>(
      dynamic id, TModel data) async {
    final resource = "order/update";
    Map body = (data as OrderModel).toJson();
    body.removeWhere((key, value) =>
        value == null || ((value is List || value is Map) && value.isEmpty));
    body.remove("idOrder");
    body.remove("userName");
    body.remove("qrCode");
    log("$baseUrl$resource");

    final himpl = HeaderRequestImpl(
      idpKey: "apiez",
    );
    Map<String, String> headers = await himpl.getHeaders();
    onStatusCodeListener(401, (provider, response, code) async {
      log("Probando manejo de CallBack para Update Order=$code");
      return provider;
    }).onStatusCodeListener(204, (provider, response, code) async {
      log("Probando manejo de CallBack para Update Order=$code");
      httpClient.defaultDecoder =
          defaultDecoder = super.defaultDecoder = (map) {
        return OrderModel.fromJson({}) as TModel;
      };
      return provider;
    }).onStatusCodeListener(500, (provider, response, code) async {
      log("Probando manejo de CallBack para Update Order=$code");
      return provider;
    });
    final resp = await processResponse(
      put(
        resource,
        body,
        headers: headers,
        decoder: (data) {
          if (data is Map<String, dynamic>) {
            return OrderModel.fromJson(data);
          }
        },
      ),
      provider: this,
    );
    return resp.fold((l) => Left(l), (resp) {
      if (resp.body is OrderModel) {
        return Right(resp.body as TModel);
      } else {
        return Right((resp.bodyString!.isNotEmpty
            ? OrderModel.fromJson(json.decode(resp.bodyString!))
            : OrderModel.fromJson({})) as TModel);
      }
    });
/*
    final response = await put(resource, body);

    if (response.statusCode == 200 && response.body != null) {
      return Right(response.body);
    }

    return Left(HttpServerException(
        fault: response.body is Fault
            ? response.body
            : Fault.fromJson({
                "faultCode": "500",
                "type": "Error",
                "message": "Error en la llamada de actualización de la orden.",
                "description":
                    "Se ha producido un error al intentar actualizar la orden."
              })));*/
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
